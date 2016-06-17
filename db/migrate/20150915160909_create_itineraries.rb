class CreateItineraries < ActiveRecord::Migration
  def change
    create_table :itineraries do |t|
      t.string      :cnnrightle
      t.time        :fromhour
      t.time        :tohour
      t.string      :weekday
      t.string      :streetname
      t.integer     :lf_fadd
      t.integer     :lf_toadd
      t.integer     :rt_fadd
      t.integer     :rt_toadd
      t.boolean     :week1ofmon
      t.boolean     :week2ofmon
      t.boolean     :week3ofmon
      t.boolean     :week4ofmon
      t.boolean     :week5ofmon

      t.string      :street
      t.integer     :start_num
      t.integer     :end_num
      t.int4range   :range
      t.text        :even_sched
      t.text        :odd_sched
      t.boolean     :holidays

      t.string      :side
      t.boolean     :match
      t.boolean      :floor_even

      t.timestamps null: false
    end
  end
end
