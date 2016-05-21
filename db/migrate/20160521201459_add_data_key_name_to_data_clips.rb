class AddDataKeyNameToDataClips < ActiveRecord::Migration
  def change
    add_column :data_clips, :name, :string
  end
end
