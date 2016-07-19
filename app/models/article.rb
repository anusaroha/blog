class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  belongs_to :category
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true,
                    length: { minimum: 5 }


  def self.search(search)
    if search
      self.where("name like ?", "%#{search}%")
    else
      self.all
    end
  end

    def new_first_comments
      comments.order(created_at: :desc)
    end

    def like_for(user)
      likes.find_by_user_id(user)
    end

    def tag_names=(names)
      self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
      end
    end

    def tag_names
      self.tags.map(&:name).join(", ")
    end

    paginates_per 10

end
