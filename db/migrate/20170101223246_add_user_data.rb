class AddUserData < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :slack_username, :string, null: true
    add_column :users, :facebook_username, :string, null: true
    add_column :users, :twitter_username, :string, null: true
    add_column :users, :github_username, :string, null: true
    add_column :users, :profile_image_url, :string, null: true
    add_column :users, :position_name, :string, null: true
    add_column :users, :member_since, :datetime, null: false
    add_column :users, :is_admin, :boolean, null: false, default: false
    add_column :users, :biography, :text, null: true
    add_column :users, :card_id, :string, null: true
  end
end
