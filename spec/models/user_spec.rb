require "rails_helper"

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create(:user) }

  it "creates punch in record" do
    expect(user.punches.count).to eq 0
    user.punch_in
    expect(user.punches.count).to eq 1
    expect(user.punches.first.in?).to be true
  end

  it "creates punch out record" do
    expect(user.punches.count).to eq 0
    user.punch_out
    expect(user.punches.count).to eq 1
    expect(user.punches.first.out?).to be true
  end
end
