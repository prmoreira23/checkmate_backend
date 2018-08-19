class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: "User"
  has_many :actions
  after_create :create_action
  before_create :before_create_action
  validates :user, :recipient, presence: true

  def compile_contract
    self.content
  end

  private

  def before_create_action
    pdf = generate_pdf(this)
    self.contractDigest_hash = Digest::SHA256.file(pdf).hexdigest
  end

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
