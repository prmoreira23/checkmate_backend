class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: "User"
  has_many :actions
  after_create :create_action
  before_create :before_create_action
  validates :user, :recipient, presence: true

  def generate_pdf
    content = <<-HTML
      <h1 style="font-size:100px">#{self.title}</h1>
      <p style="font-size:40px">Author: #{self.user.full_name}</p>
      <p style="font-size:40px">Recipient: #{self.recipient.full_name}</p>
      <p style="font-size:40px">Content: #{self.content}</p>
    HTML
    WickedPdf.new.pdf_from_string(content)
  end


  private
  def get_hash
    file_name = File.join(Rails.root, 'storage', 'pdfs', [self.title, Time.now, '.pdf'].join(""))
    file = File.new(file_name, "wb")
    begin
      file.write(self.generate_pdf)
      self.pdf = file.path
      Digest::SHA256.file(file).hexdigest
    ensure
      file.close
    end
  end

  def before_create_action
    self.contract_hash = get_hash
  end

  def create_action
    data = {
      user_id: self.user.id,
      recipient_id: self.recipient_id,
      contract_hash: self.contract_hash,
      previous_hash: Action.last && Action.last.action_hash
    }
    action = self.actions.build(action_type: "CREATE_CONTRACT", user: self.user, action_hash: Digest::SHA256.hexdigest(data.to_json), previous_hash: Action.last && Action.last.action_hash)
    action.save
  end
end
