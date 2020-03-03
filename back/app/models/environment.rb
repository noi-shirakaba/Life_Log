class Environment < ApplicationRecord
  validates :situation, presence: true, length: { in: 3..130}


  has_many :actions
  has_many :emotions
  has_many :reactions
  has_many :thoughts
  belongs_to :user, optional: true
end