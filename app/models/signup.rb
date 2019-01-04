# == Schema Information
#
# Table name: signups
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  signup_day   :integer          not null
#  signup_time   :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Signup < ApplicationRecord

  SIGNUP_DAYS = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
  #SIGNUP_TIMES = ['3-4pm', '4-5pm', '5-6pm', '7-8pm', '8-9pm']
  SIGNUP_QTYS = ['1', '2', '3', '4', '5', '6', '7', '8', '9']

  has_many :user_signups
  has_many :users, :through => :user_signups

  #validates :name, presence: true
  validates :signup_day, inclusion: { in: SIGNUP_DAYS }

end
