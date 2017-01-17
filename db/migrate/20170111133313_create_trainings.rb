class CreateTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :trainings do |t|
      t.string :name, null: false
      t.string :training_type, null: false
      t.string :icon
      t.timestamps
    end

    # the many to many relationship for users and trainings
    create_table :user_trainings, id: false do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :training, index: true, null: false
      t.timestamps
    end

    # to record who creates the user trainings
    add_reference :user_trainings, :created_by, references: :users, index: true, null: false
    add_foreign_key :user_trainings, :users, column: :created_by_id
    add_index :user_trainings, [:user_id, :training_id], unique: true
  end
end
