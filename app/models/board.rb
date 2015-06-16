class Board < ActiveRecord::Base
  has_many :tickets, inverse_of: :board
  validates :title, presence: true
end
