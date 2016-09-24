class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :title
      t.timestamps null: false
    end

    create_table :blogs_tags do |t|
      t.integer :blog_id
      t.integer :tag_id
    end
  end
end
