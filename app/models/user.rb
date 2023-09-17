class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true 
  validates :profile, length: { maximum: 200 } 

  has_many :cards
  mount_uploader :profile_image, ProfileImageUploader    

  def generate_sns_url
    base_url = case sns_type
      when 'Facebook' then "https://www.facebook.com/"
      when 'Twitter' then "https://twitter.com/"
      when 'Instagram' then "https://instagram.com/"
      when 'LinkedIn' then "https://www.linkedin.com/in/"
      else nil
    end

    "#{base_url}#{sns_username}" if base_url
  end
end
