class UserTraining < ApplicationRecord
  self.primary_key = [:user_id, :training_id]

  belongs_to :user
  belongs_to :training
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
end
