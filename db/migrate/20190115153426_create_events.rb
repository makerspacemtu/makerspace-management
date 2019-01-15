class CreateEvents < ActiveRecord::Migration[5.0]
  def change

    create_table :events do |t|
      t.string :name, null: false
      t.string :audience, null: false
      t.string :org_name, null: false
      t.string :org_contact_name, null: false
      t.text :desc, null: false
      t.column :event_start,  :datetime, null: false
      t.column :event_end,  :datetime, null:false

      t.timestamps

    end
  end
end
