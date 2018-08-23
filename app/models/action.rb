class Action < ApplicationRecord
  belongs_to :user
  belongs_to :contract
  before_create :func_before_create

  private
  def func_before_create
    prev_hash = Action.last && Action.last.action_hash
    data = {
      user_id: self.contract.user_id,
      recipient_id: self.contract.recipient_id,
      contract_hash: self.contract.contract_hash,
      previous_hash: prev_hash
    }
    self.action_type = "USER_SIGNATURE" unless self.action_type
    self.action_hash = Digest::SHA256.hexdigest(data.to_json)
    self.previous_hash = prev_hash
  end
end
