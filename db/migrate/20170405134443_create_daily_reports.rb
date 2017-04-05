class CreateDailyReports < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_reports do |t|
      t.datetime :shift_start, null: false
      t.datetime :shift_end, null: false
      t.text :notes, null: false

      t.timestamps
    end

    create_join_table :daily_reports, :users do |t|
      t.index [:daily_report_id, :user_id]
    end
  end
end
