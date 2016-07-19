class Category < ActiveRecord::Base
  has_many :articles, dependent: :nullify
  validates :title, presence: true, uniqueness: true
end
