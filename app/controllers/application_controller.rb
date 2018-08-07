class ApplicationController < ActionController::API
  def hi
    render json: {name: "Pablo"}
  end
end
