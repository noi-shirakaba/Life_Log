class RenameImageColumToThoughts < ActiveRecord::Migration[5.2]
  def change
    rename_column :thoughts, :image, :thought_content
  end
end
