class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # has_many :friends, through: :friendships
  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships
  # has_many :pending_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend
  has_many :inverted_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverted_friendships, source: :user
  def friends
    friends_i_sent_friendship = Friendship.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_friendship = Friendship.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = friends_i_sent_friendship + friends_i_got_friendship
    User.where(id: ids)
  end

  def friend_with?(user)
    Friendship.confirmed_record?(id, user.id)
  end

  def send_friendship(user)
    friendships.create(friend_id :user.id)
  end

  def friend?(user)
    friends.include?(user)
  end

end
