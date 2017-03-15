class AddUserInterestSpecialty < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :specialties, :text, null: true
    add_column :users, :interests, :text, null: true
  end
end
