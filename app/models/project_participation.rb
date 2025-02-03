class ProjectParticipation < ApplicationRecord
  belongs_to :project
  belongs_to :user
end
