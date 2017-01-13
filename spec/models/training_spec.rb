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

require 'rails_helper'

RSpec.describe Training, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
