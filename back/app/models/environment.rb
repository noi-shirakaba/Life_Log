class Environment < ApplicationRecord
  validates :situation, presence: true, length: { in: 3..130}

  belongs_to :user, optional: true
end