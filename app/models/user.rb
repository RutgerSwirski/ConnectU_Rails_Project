class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :profile_picture, PhotoUploader

  has_many :trips
  has_many :activities
  has_many :orders
  has_many :reviews
  has_many :flats
  has_many :sent_friend_requests, class_name: 'Friend', foreign_key: 'sender_id'
  has_many :recieved_friend_requests, class_name: 'Friend', foreign_key: 'recipient_id'
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :recieved_messages, class_name: 'Message', foreign_key: 'recipient_id'
  has_many :favourites
end
