class Post < ActiveRecord::Base
  has_many :comments
  has_many :categories_posts
  has_many :categories, through: :categories_posts

  has_many :tags
  belongs_to :user

  validates :title, presence: true

  def categories_titles
    # categories.map(&:title).join(', ')
    categories.pluck(:title).join(', ')
  end

end
