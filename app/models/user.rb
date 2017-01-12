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
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string           not null
#  last_name              :string           not null
#  slack_username         :string
#  facebook_username      :string
#  twitter_username       :string
#  github_username        :string
#  profile_image_url      :string
#  position_name          :string
#  member_since           :datetime         not null
#  biography              :text
#  card_id                :string
#  user_type              :string           not null
#

class User < ApplicationRecord
  USER_TYPES = ['Admin', 'Staff', 'Member']

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :punches

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :member_since, presence: true
  validates :user_type, inclusion: { in: USER_TYPES }

  scope :checked_in_users, -> { joins(:punches)
    .where('punches.created_at = (SELECT MAX(punches.created_at) FROM punches WHERE punches.user_id = users.id)')
    .where('punches.in = false')
    .group('users.id')
  }

  scope :checked_in_users_count, -> { checked_in_users.to_a.count }


  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    user_type == 'Admin'
  end

  def staff?
    user_type == 'Staff'
  end

  def member?
    user_type == 'Member'
  end

  def most_recent_punch
    self.punches.order(created_at: :desc).first
  end

  def punch_in
    self.punches.create(in: true)
  end

  def punch_out
    self.punches.create(in: false)
  end
end
