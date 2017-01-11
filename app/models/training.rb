# == Schema Information
#
# Table name: trainings
#
#  id         :integer          not null, primary key
#  name       :string
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Training < ApplicationRecord
  has_and_belongs_to_many :users
end
