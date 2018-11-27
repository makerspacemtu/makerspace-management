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
  SIGNUP_TIMES = ['3-4pm', '4-5pm', '5-6pm', '7-8pm', '8-9pm']

  has_many :user_signups
  has_many :users, :through => :user_signups

  validates :name, presence: true
  validates :signup_day, inclusion: { in: SIGNUP_DAYS }
  validates :signup_time, inclusion: { in: SIGNUP_TIMES }

  def signup_day_format
    case self.signup_day
    when "Monday"
      1
    when "Tuesday"
      2
    when "Wednesday"
      3
    when "Thursday"
      4
    when "Friday"
      5
    when "Saturday"
      6
    when "Sunday"
      7
    end
  end

  def signup_time_format
    case self.signup_time
    when "3-4pm"
      15
    when "4-5pm"
      16
    when "5-6pm"
      17
    when "6-7pm"
      18
    when "7-8pm"
      19
    when "8-9pm"
      20
    end
  end
end
