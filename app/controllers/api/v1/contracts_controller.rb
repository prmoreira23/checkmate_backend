class Api::V1::ContractsController < ApplicationController

  def create
    @user = current_user
    if @user
      @contract = @user.outcoming_contracts.build(contract_params)
      if @contract && @contract.save
        render json: @contract, status: :created
      else
        render json: { errors: @contract.errors.full_messages }, status: :unprocessible_entity
      end
    else
      render json: false.to_json, status: :unauthorized
    end
  end

  def get_pdf
    @contract = Contract.find_by(id: request.headers["id"])
    pdf = WickedPdf.new.pdf_from_string("<h1>#{@contract.title}</h1>")
    send_data pdf, filename: "#{@contract.title}.#{Time.now}.pdf"
  end

  def incoming
    @user = current_user
    if @user
      @incoming_contracts = @user.incoming_contracts
      render json: @incoming_contracts, each_serializer: ContractSerializer
    else
      render json: false.to_json, status: :unauthorized
    end
  end

  def outcoming
    @user = current_user
    if @user
      @outcoming_contracts = @user.outcoming_contracts
      render json: @outcoming_contracts, each_serializer: ContractSerializer
    else
      render json: false.to_json, status: :unauthorized
    end
  end

  def update
    @contract.update(contract_params)
    if @contract.save
      render json: @contract, status: :accepted
    else
      render json: { errors: @contract.errors.full_messages }, status: :unprocessible_entity
    end
  end

  private

  def contract_params
    params.require(:contract).permit(:recipient_id, :title, :content)
  end

  def find_contract
    @contract = Contract.find(params[:id])
  end
end
