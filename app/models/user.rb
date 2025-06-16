class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :orders

  validates :password,
            format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: ' is invalid. Include both letters and numbers' }
  validates :nickname, presence: true
  validates :family_name, presence: true,
                          format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: ' is invalid. Input full-width characters' }
  validates :last_name, presence: true,
                        format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: ' is invalid. Input full-width characters' }
  validates :kana_family_name, presence: true,
                               format: { with: /\A[ァ-ヶー]+\z/, message: ' is invalid. Input full-width katakana characters' }
  validates :kana_last_name, presence: true,
                             format: { with: /\A[ァ-ヶー]+\z/, message: ' is invalid. Input full-width katakana characters' }
  validates :birth_date, presence: true
end
