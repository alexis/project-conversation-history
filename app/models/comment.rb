class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  def save_with_project_change(as:)
    transaction do
      save!
      trigger_project_change(as)
    end
  rescue ActiveRecord::RecordInvalid
    return unless valid?
    raise
  end

  def delete_with_project_change(as:)
    transaction do
      update!(deleted_at: Time.current)
      trigger_project_change(as)
    end
  rescue ActiveRecord::RecordInvalid
    return unless valid?
    raise
  end

  private

  def trigger_project_change(user)
    if previous_changes["deleted_at"] in [nil, Time]
      kind = "comment_deleted"
      description = "Comment posted at #{created_at} was deleted by #{user.name}"
    elsif previously_new_record?
      kind = "comment_posted"
      description = "#{user.name} posted a comment"
    else
      kind = "comment_updated"
      description = "Comment posted at #{created_at} was updated by #{user.name}"
    end

    project.project_changes.create!(comment: self, user:, kind:, description:, details: { comment_diff: previous_changes })
  end
end
