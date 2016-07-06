class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :count_messages

  def attributes(*args)
    data = super
    data[:token] = UserToken.generate(object.id) if object.new_record?
    data
  end

  def token
    UserToken.generate(object.id)
  end

end
