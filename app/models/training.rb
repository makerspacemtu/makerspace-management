# == Schema Information
#
# Table name: trainings
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  type       :string           not null
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Training < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, presence: true
end
