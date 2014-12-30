class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :url
      t.string :content
      t.string :channel
      t.string :desc
      t.timestamps null: false
    end
  end
end
