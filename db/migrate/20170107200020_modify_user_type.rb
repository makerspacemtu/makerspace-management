class ModifyUserType < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :is_admin
    add_column :users, :user_type, :string, null: false
  end
end
