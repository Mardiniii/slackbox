class RenameIsUrlToHasUrlsOnDataClip < ActiveRecord::Migration
  def change
    rename_column :data_clips, :is_url, :has_urls
  end
end
