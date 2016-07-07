class User < ApplicationRecord
  has_many :messages
  has_and_belongs_to_many :chats
  validates :username,  :presence => true,  :uniqueness => true
  validates :password, :presence => true

# simple password encrypting
  before_create { self.password = self.class.encrypt_password(self.password)}

  def self.encrypt_password(password)
    Digest::SHA1.hexdigest password
  end

  def count_messages
    # Convert to integer if redis not found this record.
    # For example if record just created
    $redis.get("user:#{id}:messages").to_i
  end

end
