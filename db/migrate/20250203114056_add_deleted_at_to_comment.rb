class AddDeletedAtToComment < ActiveRecord::Migration[7.2]
  def change
    add_column :comments, :deleted_at, :timestamp
  end
end
