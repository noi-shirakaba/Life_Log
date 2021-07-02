class Environment < ApplicationRecord
  validates :situation, presence: true, length: { in: 3..130}
  has_many :actions, dependent: :destroy
  has_many :emotions, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :thoughts, dependent: :destroy
  belongs_to :user, optional: true
end