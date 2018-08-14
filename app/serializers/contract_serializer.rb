class ContractSerializer < ActiveModel::Serializer
  attributes :id, :user, :recipient, :title, :content, :status
  has_one :user, :recipient
end
