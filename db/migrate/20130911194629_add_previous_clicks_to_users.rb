class AddPreviousClicksToUsers < ActiveRecord::Migration
  def change
    add_column :links, :prev_clicks, :integer
  end
end
