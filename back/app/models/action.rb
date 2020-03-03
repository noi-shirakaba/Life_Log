class Action < ApplicationRecord
  validates :action_category, presence: true, length: { in: 3..130}
  belongs_to :environment
end
