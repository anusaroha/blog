class Article < ActiveRecord::Base
  has_many :comments
  validates :title, presence: true,
                    length: { minimum: 5 }


    def self.search(search)
      where("title ILIKE ? OR text ILIKE ?", "%#{search}% ", "%#{search}%")
    end


end
