class Ticket < ActiveRecord::Base
  belongs_to :board, inverse_of: :tickets
end
