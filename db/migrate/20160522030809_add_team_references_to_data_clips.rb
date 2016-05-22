class AddTeamReferencesToDataClips < ActiveRecord::Migration
  def change
    add_reference :data_clips, :team, index: true, foreign_key: true
  end
end
