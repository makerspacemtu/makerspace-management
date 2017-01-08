# == Schema Information
#
# Table name: punches
#
#  id         :integer          not null, primary key
#  in         :boolean          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Punch < ApplicationRecord
end
