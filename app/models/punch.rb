# == Schema Information
#
# Table name: punches
#
#  id         :integer          not null, primary key
#  in         :boolean          not null
#  user_id    :integer          not null
#  reason     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Punch < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  # true is a check in, false is a check out
  validates :in, inclusion: { in: [ false, true ] }
  # all options for checking in
  validationarray = ["personal_project", "class_project", "event", "class_session", "coaching", "other"].to_a.concat((0.to_s...1000.to_s).to_a)

  validates :reason, inclusion: { in: validationarray }, allow_blank: true

  def in?
    self.in
  end

  def out?
    !in?
  end

  def fancy_punch_datetime
    return "never" if self.created_at.nil?
    self.created_at.strftime('%B %-d, %Y at %l:%M%P')
  end

  def self.punches_created_by_week
    punches = self.where(in: true).group("DATE_TRUNC('week', created_at)").count

    current_week = punches.keys[0]
    while current_week < Time.now
      unless punches.key?(current_week)
        # add the missing weeks
        punches[current_week] = 0
      end

      current_week += 7.days
    end

    punches.sort.to_h
  end

  def self.punches_created_by_month
    punches = self.where(in: true).group("DATE_TRUNC('month', created_at)").count

    current_month = punches.keys[0]
    while current_month < Time.now
      unless punches.key?(current_month)
        # add the missing months
        punches[current_month] = 0
      end

      current_month += 30.days
    end

    punches.sort.to_h
  end

  def self.reason_counts
    punches = self.where(in: true).group("DATE_TRUNC('week', created_at)").count
    event_validationarray = [ "event" ].to_a.concat((0.to_s...1000.to_s).to_a)
    # punches_last_range = Punch.where(in: true).where("created_at > ?", Time.now-3.months)
    punches_last_range = Punch.where(in: true)


    personal_project_count = punches_last_range.all.where(reason: "personal_project").count
    class_project_count = punches_last_range.all.where(reason: "class_project").count
    event_count = punches_last_range.all.where(reason: event_validationarray).count
    class_session_count = punches_last_range.all.where(reason: "class_session").count
    coaching_count = punches_last_range.all.where(reason: "coaching").count

    reasoncounts = Hash["Personal Project",personal_project_count,"Class Project",class_project_count, "Event",event_count,"Class Session",class_session_count,"Coaching",coaching_count]
    reasoncounts.sort.to_h
  end
end
