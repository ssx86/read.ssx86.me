class Word < ActiveRecord::Base
  validates :word, uniqueness: true
end
