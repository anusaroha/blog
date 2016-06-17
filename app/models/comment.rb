class Comment < ActiveRecord::Base
  belongs_to :article
  validates :body, presence: true, uniqueness: {scope: :article_id}
end
