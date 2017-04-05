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

require 'rails_helper'

RSpec.describe DailyReport, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
