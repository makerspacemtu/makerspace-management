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

class User < ApplicationRecord
  PAGE_SIZE = 20
  USER_TYPES = ['Admin', 'Staff', 'Member']

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :punches
  has_many :user_trainings
  has_many :trainings, :through => :user_trainings

  has_and_belongs_to_many :daily_reports

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :member_since, presence: true
  validates :user_type, inclusion: { in: USER_TYPES }

  scope :checked_in_users, -> { joins(:punches)
    .where('punches.created_at = (SELECT MAX(punches.created_at) FROM punches WHERE punches.user_id = users.id)')
    .where('punches.in = true')
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

  def checked_in?
    if most_recent_punch.present?
      most_recent_punch.in?
    else
      false
    end
  end

  def has_visited?
    # check if they've visited the space at least once
    most_recent_punch.present?
  end

  def any_social_media?
    self.twitter_username.present? ||
    self.facebook_username.present? ||
    self.github_username.present? ||
    self.slack_user_id.present?
  end

  def member_since_fancy
    self.member_since.strftime('%B %-d, %Y')
  end

  def last_sign_in_fancy
    return "never" if self.last_sign_in_at.nil?
    self.last_sign_in_at.strftime('%B %-d, %Y')
  end

  def obfuscated_email
    # obfuscate the entire email except for the first two characters
    obfuscation_length = self.email.split("@").first.length - 2
    # generate the necessary string of stars
    sub_string = '*' * (obfuscation_length)
    # replace the characters we want to hide
    self.email.gsub(/.{0,#{obfuscation_length}}@/, sub_string + "@")
  end

  def self.users_created_by_week
    users = self.group("DATE_TRUNC('week', created_at)").count

    current_week = users.keys[0]
    while current_week < Time.now
      unless users.key?(current_week)
        # add the missing weeks
        users[current_week] = 0
      end

      current_week += 7.days
    end

    users.sort.to_h
  end
end
