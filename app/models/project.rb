class Project < ApplicationRecord
  has_many :comments
  has_many :project_changes
  has_many :project_participations
  has_many :users, through: :project_participations

  enum :status, %w[open in_progress completed archived].index_by(&:itself), validate: true
end
