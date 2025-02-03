class CreateProjectChanges < ActiveRecord::Migration[7.2]
  def change
    create_table :project_changes do |t|
      t.string :kind, null: false
      t.string :description, null: false
      t.jsonb :details, null: false, default: {}
      t.timestamp :triggered_at, null: false
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.references :comment, null: true, foreign_key: true

      t.timestamps
    end

    add_check_constraint :project_changes, "jsonb_typeof(details) = 'object'", name: "project_change_details_is_object"
  end
end
