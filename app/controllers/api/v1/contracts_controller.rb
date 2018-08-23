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

    pdf = File.open(@contract.pdf, "rb")
    begin
      send_file pdf, filename: "#{@contract.title}.#{Time.now}.pdf"
    ensure
      pdf.close
    end
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

  def check_pdf
    contract_hash = Digest::SHA256.file(params["file"].tempfile).hexdigest
    contract = Contract.find_by(contract_hash: contract_hash)
    if contract
      render json: contract
    else
      render json: {contract: {contract_hash: contract_hash}}
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
