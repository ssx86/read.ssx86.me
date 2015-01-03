class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.string :means
      t.string :part
      t.timestamps null: false
    end
  end
end
