# == Schema Information
#
# Table name: daily_reports
#
#  id          :integer          not null, primary key
#  shift_start :datetime         not null
#  shift_end   :datetime         not null
#  notes       :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class DailyReport < ApplicationRecord
  validates :shift_start, presence: true
  validates :shift_end, presence: true
  validates :notes, presence: true

  has_and_belongs_to_many :users
end
