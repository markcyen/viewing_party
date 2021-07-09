class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :party

  enum status: ['host', 'attendee']
end
