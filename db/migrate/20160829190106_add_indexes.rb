class AddIndexes < ActiveRecord::Migration
  def change
    add_index :teams, :slack_id
    add_index :channels, :slack_id
  end
end
