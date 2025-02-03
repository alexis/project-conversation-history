class User < ApplicationRecord
  has_many :project_participations
  has_many :projects, through: :project_participations
end
