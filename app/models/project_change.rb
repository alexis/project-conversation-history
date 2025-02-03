class ProjectChange < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :comment, optional: true

  enum :kind, %w[comment_posted status_changed comment_updated comment_deleted].index_by(&:itself), validate: true

  validates :comment, presence: true, strict: true, if: :comment_required?

  before_validation :set_default_triggered_at, on: :create

  def default_triggered_at
    return comment.created_at if comment_posted?
    return comment.deleted_at if comment_deleted?

    Time.current
  end

  private

  def set_default_triggered_at
    self.triggered_at = default_triggered_at if triggered_at.nil?
  end

  def comment_required?
    comment_posted? || comment_updated? || comment_deleted?
  end
end
