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

class Survey < ApplicationRecord

  COMPETENCY = [0,1,2,3,4]

  validates :tool_name, presence: true
  validates :tool_id, presence: true
  validates :user_id, presence: true
  #validates :audience,  inclusion: { in: %w[Private Public] }


  #Plotly plot Data
  def self.competency_counts
    usercompetencies = self.group(:tool_name).average(:competency).sort.to_h
    usercompetencies
  end

  def self.competency_counts_qty
    usercompetencies_qty = self.group(:tool_name).count.sort.to_h
    usercompetencies_qty = usercompetencies_qty.each{ |key,str| usercompetencies_qty[key] = "# of Data Points: #{str}" }
    usercompetencies_qty
  end
end
