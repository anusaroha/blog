class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :user

  validates :title, presence: true,
                    length: { minimum: 5 }


    def self.search(search)
      where("title ILIKE ? OR text ILIKE ?", "%#{search}% ", "%#{search}%")
    end

    def new_first_comments
      comments.order(created_at: :desc)
    end

    belongs_to :category_id

end
