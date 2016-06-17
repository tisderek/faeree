module ImportHelper

  class ItineraryImport

    attr_accessor :record
    attr_accessor :itinerary

    class << self
        def process_all
          seed_file = File.join(Rails.root, 'db', 'itineraries_seed', 'itineraries_seed.shp')
          RGeo::Shapefile::Reader.open(seed_file) do |file|
            file.each do |item|
              ItineraryImport.new(item).process_record
            end
            file.rewind
            item = file.next
          end
        end
    end

    def initialize(record)
      @record = Hash[record.attributes.map{|(k,v)| [k.downcase.to_sym,v]}]
    end


    def process_record
      set_record_range
      set_record_bounds
      set_record_street
      find_or_create_itinerary
      record_street_side
      # find_or_create_schedule
      # add_recurrence_rule
    end

    def find_or_create_itinerary
      @itinerary = Itinerary.create(
        street: @record[:street],
        start_num: @record[:range].min,
        end_num: @record[:range].max,
      )
      @itinerary.update(
        match: lowest_and_cnn_match?,
        floor_even: range_floor_even?,
        weekday: @record[:weekday]
      )
    end

    def record_street_side
      binding.pry
      # if lowest_and_cnn_match?
      #   if range_floor_even?
      #     @itinerary.update(
      #       even_sched: IceCube::Schedule.new.
      #     )
      #     )
      #   else
      #     @itinerary.update(
      #       odd_sched: IceCube::Schedule.new.add_recurrence_rule(
      #         IceCube::Rule.weekly.day(on(@itinerary.weekday))
      #       )
      #     )
      #   end
      # else
      #   if range_floor_even?
      #     @itinerary.update(
      #       odd_sched: IceCube::Schedule.new.add_recurrence_rule(
      #         IceCube::Rule.weekly.day(on(@itinerary.weekday))
      #       )
      #     )
      #   else
      #     @itinerary.update(
      #       even_sched: IceCube::Schedule.new.add_recurrence_rule(
      #         IceCube::Rule.weekly.day(on(@itinerary.weekday))
      #       )
      #     )
      #   end
      # end
    end

    def col_of_lowest
      a = @record.values_at(:lf_fadd, :rt_toadd) # isn't this (:lf_fadd, :rt_fadd)??
      a.index(a.min) == 0 ? "L" : "R"
    end

    def range_floor_even?
      a = @record.values_at(:lf_fadd, :rt_toadd)
      a.index(a.min).even?
    end

    def lowest_and_cnn_match?
      col_of_lowest == @record[:cnnrightle]
    end


    # set better @record attributes

    def set_record_range
      record_range = @record.values_at(:lf_fadd, :lf_toadd, :rt_fadd, :rt_toadd).minmax
      record_range.map! { |n| n.to_i }
      @record[:range] = (record_range.min)..(record_range.max + 1)
    end

    def set_record_bounds
      @record[:start_num] = @record[:range].min
      @record[:end_num] = @record[:range].max
    end

    def set_record_street
      replace_abbreviated_address
      address = @record[:streetname]
      if is_a_integer?(address.first)
        address_array = address.split(" ")
        address_array[0].slice!(0) if address_array[0].first.to_i == 0
        number = address_array[0].downcase
        remainder = address_array[1..-1].join(" ").titlecase
        @record[:street] = "#{number} #{remainder}"
      else
        @record[:street] = address.titlecase
      end
    end

    def is_a_integer?(obj)
      obj.to_i.to_s == obj
    end

    def replace_abbreviated_address
      name_array = @record[:streetname].split(" ")
      name_array << LONG_FORM_ADDRESSES[name_array[-1]]
      name_array.delete_at(-2)
      @record[:streetname] = name_array.join(" ")
    end

    LONG_FORM_ADDRESSES = {
      "ST" => "Street",
      "AVE" => "Avenue",
      "DR" => "Drive",
      "BLVD" => "Boulevard",
      "RD" => "Road",
      "CT" => "Court",
      "TER" => "Terrace",
      "ALY" => "Alley",
      "PL" => "Place",
      "WAY" => "Way"
    }
  end

end
