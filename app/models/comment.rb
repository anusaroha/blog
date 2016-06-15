class Article < ActiveRecord::Base
  has_many :comments
  include Comments::Comment
  validates :title, presence: true,
                    length: { minimum: 5 }
end
