class ChatSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_ids
end
