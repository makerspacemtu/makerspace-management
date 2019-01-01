class CreateSignups < ActiveRecord::Migration[5.0]
  def change

    create_table :signups do |t|
      t.string :signup_day, null: false
      t.column :signup_start,  :datetime
      t.column :signup_end,  :datetime
      t.integer :signup_qty, null: false
      t.timestamps

    end

    # the many to many relationship for users and signups
    create_table :user_signups do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :signup, index: true, null: false
      t.timestamps
    end


    # to record who adds their signup
    add_reference :user_signups, :created_by, references: :users, index: true, null: false
    add_foreign_key :user_signups, :users, column: :created_by_id
    add_index :user_signups, [:user_id, :signup_id], unique: true
  end
end
