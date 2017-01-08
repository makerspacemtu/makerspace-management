class CreatePunches < ActiveRecord::Migration[5.0]
  def change
    create_table :punches do |t|
      t.boolean :in, null: false
      t.belongs_to :user, index: true, null: false
      t.timestamps
    end
  end
end
