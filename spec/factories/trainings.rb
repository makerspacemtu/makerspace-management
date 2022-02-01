# == Schema Information
#
# Table name: trainings
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  training_type :string           not null
#  icon          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :training do

  end
  factory :signup do

  end
end
