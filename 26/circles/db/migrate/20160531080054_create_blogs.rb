class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.boolean :is_public, default: true
      t.belongs_to :user
      t.timestamps null: false
    end

    add_index :blogs, [:user_id]
  end
end
