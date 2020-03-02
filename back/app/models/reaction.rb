class Reaction < ApplicationRecord
  validates :content, presence: true, length: { in: 3..130}
end
