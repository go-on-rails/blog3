class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, length: {in: 4..40}
  validates :description, length: {in: 4..512}
end