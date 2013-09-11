class ChangeNameToTextInLinks < ActiveRecord::Migration
  def change
    remove_column :links, :name
    add_column :links, :name, :text
  end
end
