class AddVideoIdToSections < ActiveRecord::Migration
  def change
    add_column :sections, :video_id, :string
  end
end
