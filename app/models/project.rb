class Project < ApplicationRecord
  has_many :comments
  has_many :project_changes
  has_many :project_participations
  has_many :users, through: :project_participations

  enum :status, %w[open in_progress completed archived].index_by(&:itself), validate: true

  def save_with_project_change(as:)
    transaction do
      save!
      trigger_project_change(as) unless previously_new_record?
    end
  rescue ActiveRecord::RecordInvalid
    return unless valid?
    raise
  end

  private

  def trigger_project_change(user)
    return if previous_changes["status"].nil?

    kind = "status_changed"
    description = "#{user.name} changed status to #{status.humanize.titleize}"

    project_changes.create!(user:, kind:, description:, details: { project_diff: previous_changes })
  end
end
