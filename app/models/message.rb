class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  validates :name, :presence => true
end
