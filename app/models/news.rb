class News < ActiveRecord::Base
  validates :url, uniqueness: true
end
