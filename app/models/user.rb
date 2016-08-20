class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         has_many :activities, dependent: :destroy
         has_many :posts, dependent: :destroy # remove a user's posts if his account is deleted.
         has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
         has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
         
         has_many :following, through: :active_relationships, source: :followed
         has_many :followers, through: :passive_relationships, source: :follower
         
         has_many :comments, dependent: :destroy
         # helper methods
         has_attached_file :avatar, styles: { profile: "200x200>", side: "50x50>" , nav: "25x25>", thumb: "35x35>" }, default_url: "/avatar.png"
         validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
         has_attached_file :cover, styles: { main: "100%x500>", side: "261x145>" }, default_url: "/banner.jpg"
         validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
         # follow another user
         def follow(other)
           active_relationships.create(followed_id: other.id)
         end
         
         # unfollow a user
         def unfollow(other)
           active_relationships.find_by(followed_id: other.id).destroy
         end
         
         # is following a user?
         def following?(other)
           following.include?(other)
         end       
        
end
