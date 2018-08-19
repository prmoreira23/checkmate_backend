class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::MimeResponds

  def generate_pdf(contract)
    content = <<-HTML
      <h1 style="font-size:100px">#{@contract.title}</h1>
      <p style="font-size:40px">Author: #{@contract.user.full_name}</p>
      <p style="font-size:40px">Recipient: #{@contract.recipient.full_name}</p>
      <p style="font-size:40px">Content: #{@contract.content}</p>
    HTML

    WickedPdf.new.pdf_from_string(content)
  end

  def issue_token(payload)
    JWT.encode(payload, secret)
  end

  def current_user
    User.find_by(id: decoded_token)
  end

  def token
    request.headers['Authorization']
  end

  def decoded_token
    if token
      begin
        decoded = JWT.decode(token, secret)
        decoded[0]["id"]
      rescue JWT::DecodeError
        ""
      end
    else
      ""
    end
  end

  def secret
    "screwthisbutineverknewwhatthiswas"
  end

end
