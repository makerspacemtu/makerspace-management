class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string  :key,           :null => false
      t.text    :value,         :null => true
      t.integer :base_obj_id,   :null => true
      t.string  :base_obj_type, :null => true

      t.timestamps :null => false
    end

    add_index :settings, :key, :unique => true
    add_index :settings, :base_obj_id, :unique => true
    add_index :settings, :base_obj_type, :unique => true
  end
end
