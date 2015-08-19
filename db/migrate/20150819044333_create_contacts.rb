class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :contact_name, null:false
      t.string :contact_phone_number, null:false
      t.integer :user_id, null:false

      t.timestamps null: false
    end
  end
end
