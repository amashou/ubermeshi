# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  mount_uploader :image, ImageUploader
  has_many :posts
  has_many :favorites
  has_many :favorite_posts, through: :favorites, source: :post

  #statusが選択されていること
  STATUS = { HeavyUser: 0, User: 1, Driver: 2 }
  enum status: STATUS
  # validates :status, inclusion: { in: STATUS.keys.concat(STATUS.keys.map(&:to_s)) }, exclusion: { in: [nil] }
  #不正なEmailアドレスが送信されていないこと＋存在していること
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }


end
