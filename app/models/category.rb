class Category < ActiveRecord::Base
  has_many :posts

  validates :title, presence: true,
                    length: { minimum: 3 }
end
