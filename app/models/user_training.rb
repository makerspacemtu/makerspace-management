# == Schema Information
#
# Table name: user_trainings
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  training_id   :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  created_by_id :integer          not null
#

class UserTraining < ApplicationRecord
  belongs_to :user
  belongs_to :training
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"

  def self.training_counts
    usertrainings = self.group(:training_id).count
    usertrainings = usertrainings.sort.to_h
    usertrainings = usertrainings.reject{|i,j| !Training.exists?(id: i)}
    usertrainings = usertrainings.transform_keys { |key| Training.find(key).name }
    usertrainings
  end

end
