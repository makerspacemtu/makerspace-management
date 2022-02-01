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

FactoryBot.define do
  factory :daily_report do

  end
end
