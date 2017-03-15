class ChangeSlackUserField < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :slack_username
    add_column :users, :slack_user_id, :string, null: true
  end
end
