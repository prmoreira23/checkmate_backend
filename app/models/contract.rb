class Contract < ApplicationRecord
  belongs_to :user
  has_many :actions
  after_create :create_action

  private
  def create_action
    data = {
      user_id: self.user.id,
      recipient_id: self.recipient_id,
      content: self.content,
      previous_hash: Action.last && Action.last.action_hash
    }
    action = self.actions.build(action_type: "CREATE_CONTRACT", user: self.user, action_hash: Digest::SHA256.hexdigest(data.to_json), previous_hash: Action.last && Action.last.action_hash)
    action.save
  end
end
