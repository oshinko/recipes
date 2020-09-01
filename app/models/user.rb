class User < ApplicationRecord
  # validates :name, uniqueness: true
  has_many :recipes, dependent: :destroy

  def to_param
    nickname
  end
end
