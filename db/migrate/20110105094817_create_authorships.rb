class CreateAuthorships < ActiveRecord::Migration
  def self.up
    create_table :authorships do |t|
      t.integer :author_id
      t.integer :article_id

      t.timestamps
    end
  end

  def self.down
    drop_table :authorships
  end
end
