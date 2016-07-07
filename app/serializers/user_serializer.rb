class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :count_messages

  def attributes(*args)
    data = super
    data[:token] = instance_options[:token] if !instance_options[:token].nil?
    data
  end

end
