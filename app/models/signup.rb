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
  #SIGNUP_QTYS = ['1', '2', '3', '4', '5', '6', '7', '8', '9']

  has_many :user_signups
  has_many :users, :through => :user_signups

  # validates :signup_id, presence: true
  # validates :signup_day , inclusion: SIGNUP_DAYS
  # validates :signup_time, inclusion: SIGNUP_TIMES

  def signup_day_format
    case self.signup_day
    when 0
      "Monday"
    when 1
      "Tuesday"
    when 2
      "Wednesday"
    when 3
      "Thursday"
    when 4
      "Friday"
    when 5
      "Saturday"
    when 6
      "Sunday"
    end
  end

  def signup_time_format
    case self.signup_time
    when 15
      "3-4pm"
    when 16
      "4-5pm"
    when 17
      "5-6pm"
    when 18
      "6-7pm"
    when 19
      "7-8pm"
    when 20
      "8-9pm"
    end
  end
 end
