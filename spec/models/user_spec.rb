# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string           not null
#  last_name              :string           not null
#  facebook_username      :string
#  twitter_username       :string
#  github_username        :string
#  profile_image_url      :string
#  position_name          :string
#  member_since           :datetime         not null
#  biography              :text
#  card_id                :string
#  user_type              :string           not null
#  specialties            :text
#  interests              :text
#  slack_user_id          :string
#

require "rails_helper"

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create(:user) }

  it "creates punch in record" do
    expect(user.punches.count).to eq 0
    user.punch_in!('personal_project')
    expect(user.punches.count).to eq 1
    expect(user.punches.first.in?).to be true
  end

  it "creates punch out record" do
    expect(user.punches.count).to eq 0
    user.punch_out!
    expect(user.punches.count).to eq 1
    expect(user.punches.first.out?).to be true
  end
end
