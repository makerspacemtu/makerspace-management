# == Schema Information
#
# Table name: event
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  desc          :string         not null
#  event_start   :datetime          not null
#  event_end     :datetime        not null
#  audience     :string          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Event < ApplicationRecord

  AUDIENCES = ['Private','Public']

  validates :name, presence: true
  validates :desc, presence: true
  #validates :audience,  inclusion: { in: %w[Private Public] }

end
