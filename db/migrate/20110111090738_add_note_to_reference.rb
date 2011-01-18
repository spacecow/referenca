class AddNoteToReference < ActiveRecord::Migration
  def self.up
    add_column :references, :note, :text
    add_column :references, :no, :integer
  end

  def self.down
    remove_column :references, :note
    remove_column :references, :no
  end
end
