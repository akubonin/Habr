class Post < ActiveRecord::Base
  has_many :comments
  has_many :categories_posts
  has_many :categories, through: :categories_posts

  has_many :tags
  has_many :subscriptions
  has_many :subscribers, source: :user, through: :subscriptions

  belongs_to :user

  validates :title, presence: true

  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :own_posts, lambda { |user|
    where(:user_id => user.id) unless user.admin?
  }

  def categories_titles
    # categories.map(&:title).join(', ')
    categories.pluck(:title).join(', ')
  end

end
