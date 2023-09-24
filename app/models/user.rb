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

  has_many :favorites, dependent: :destroy
  # もしFavoriteモデルを介してCardモデルと関連付けているならば
  has_many :cards, through: :favorites

  has_many :watchlists
  has_many :watched_cards, through: :watchlists, source: :card

  def watch(card)
    watched_cards << card unless watching?(card)
  end

  def unwatch(card)
    watched_cards.destroy(card) if watching?(card)
  end

  def watching?(card)
    watched_cards.include?(card)
  end
end
