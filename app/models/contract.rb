class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: "User"
  has_many :actions
  after_create :create_action
  before_create :before_create_action
  validates :user, :recipient, presence: true

  def status
    case self.actions.size
    when 1
      "REQUIRES BOTH PARTIES' SIGNATURES"
    when 2
      self.actions.last.user_id != self.user_id ? "REQUIRES USER'S SIGNATURE" : "REQUIRES RECIPIENT'S SIGNATURE"
    when 3
      "CONTRACT SUCCESFULLY BINDED"
    end
  end

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
    action = self.actions.build(action_type: "CONTRACT_CREATED", user: self.user)
    action.save
  end
end
