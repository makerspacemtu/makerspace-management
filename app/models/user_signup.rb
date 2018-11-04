# == Schema Information
#
# Table name: user_signups
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  signup_day   :integer          not null
#  signup_time   :datetime         not null
#  updated_at    :datetime         not null
#  created_by_id :integer          not null
#

class UserSignup < ApplicationRecord
  belongs_to :user
  belongs_to :signup
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
end
