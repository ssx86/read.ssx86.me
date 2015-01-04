class Word < ActiveRecord::Base
  validates :word, uniqueness: true

  has_and_belongs_to_many :users
end
