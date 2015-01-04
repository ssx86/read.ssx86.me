class CreateUserWords < ActiveRecord::Migration
  def change
    create_table :user_words do |t|
      t.belongs_to :user
      t.belongs_to :word

      t.integer :state
      t.integer :times
      t.timestamps null: false
    end
  end
end
