class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.string :tool_name, null: false
      t.string :tool_id, null: false
      t.integer :competency, null: false
      t.string :comments, null: true
      t.integer :user_id, null:false
      t.timestamps

    end
  end
end
