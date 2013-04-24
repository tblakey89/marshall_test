class AddExamIdToSections < ActiveRecord::Migration
  def change
    add_column :sections, :exam_id, :integer
  end
end
