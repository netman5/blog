class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def recent_posts
    user = User.find(id)
    user.posts.order(created_at: :desc).limit(3)
  end

  ROLES = %i[admin default moderator manager].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end

  def authenticate(password)
    valid_password?(password)
  end
end
