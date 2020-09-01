class User < ApplicationRecord
  has_many :recipes, dependent: :destroy

  def to_param
    nickname
  end
end
