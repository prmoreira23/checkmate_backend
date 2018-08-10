class User < ApplicationRecord
  has_secure_password
  has_many :outcoming_contracts, class_name: "Contract", foreign_key: :user_id
  has_many :incoming_contracts, class_name: "Contract", foreign_key: :recipient_id

  def full_name
    [self.first_name, self.last_name].join(" ").strip.squeeze(" ")
  end
end
