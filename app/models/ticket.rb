class Ticket < ActiveRecord::Base
  has_one :board, inverse_of: :tickets
  validates :title, presence: true
end
