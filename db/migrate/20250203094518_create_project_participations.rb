class CreateProjectParticipations < ActiveRecord::Migration[7.2]
  def change
    create_table :project_participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
