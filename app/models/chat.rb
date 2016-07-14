class Chat < ApplicationRecord
  has_many :messages
  has_and_belongs_to_many :users
  validates :name, :presence => true
  validates :users, :length => {:minimum => 1}

  def include_user?(user)
    self.users.include? user
  end
end
