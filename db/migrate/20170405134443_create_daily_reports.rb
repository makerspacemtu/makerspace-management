class CreateDailyReports < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_reports do |t|
      t.datetime :shift_start, null: false
      t.datetime :shift_end, null: false
      t.text :notes, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
