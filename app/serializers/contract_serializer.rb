class ContractSerializer < ActiveModel::Serializer
  attributes :id, :user, :contract_hash, :recipient, :title, :content, :status
  has_one :user, :recipient
end
