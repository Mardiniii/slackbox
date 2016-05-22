class RemoveSlackIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :slack_id, :string
  end
end
