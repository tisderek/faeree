class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.float       :lat
      t.float       :lng
      t.string      :street_name
      t.integer     :street_number
      t.datetime    :next_sweep

      t.integer     :user_id

      t.timestamps null: false
    end
  end
end
