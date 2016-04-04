class Award < ActiveRecord::Base
  belongs_to :lottery
  belongs_to :ticket
end
