class CreateJoinTableNewsWord < ActiveRecord::Migration
  def change
    create_join_table :news, :words do |t|
      # t.index [:news_id, :word_id]
      # t.index [:word_id, :news_id]
    end
  end
end
