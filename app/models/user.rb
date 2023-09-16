class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true 
  validates :profile, length: { maximum: 200 } 

  has_many :cards
  mount_uploader :profile_image, ProfileImageUploader    
end
