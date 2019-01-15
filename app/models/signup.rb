# == Schema Information


class Signup < ApplicationRecord

  SIGNUP_DAYS = [['Sunday', 0], ['Monday', 1], ['Tuesday', 2], ['Wednesday', 3], ['Thursday', 4], ['Friday', 5], ['Saturday', 6]]
  SIGNUP_DAYS_R = Hash[[[0, 'Sunday'], [1, 'Monday'], [2, 'Tuesday'], [3, 'Wednesday'], [4, 'Thursday'], [5, 'Friday'], [6, 'Saturday']]]

  SIGNUP_QTYS = ['1', '2', '3', '4', '5', '6', '7', '8', '9']

  has_many :user_signups
  has_many :users, :through => :user_signups

  #validates :name, presence: true
  #validates :signup_day, inclusion: { in: SIGNUP_DAYS }
  def selection_format
    time_val = signup_start.strftime("%I") + " " + signup_start.strftime("%p")+ " - " +  signup_end.strftime("%I") + " " + signup_end.strftime("%p")
    "#{SIGNUP_DAYS_R[signup_day]} #{time_val}"
  end
end
