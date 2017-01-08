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
  belongs_to :user

  validates :user_id, presence: true
  # true is a check in, false is a check out
  validates :in, inclusion: { in: [ false, true ] }

  def in?
    self.in
  end

  def out?
    !in?
  end
end
