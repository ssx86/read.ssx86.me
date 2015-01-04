class Word < ActiveRecord::Base
  validates :word, uniqueness: true

  has_many :user_words
  has_many :users, through: :user_words
end
