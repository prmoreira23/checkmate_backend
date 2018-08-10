class Api::V1::ContractsController < ApplicationController

  def index
    @contracts = Contract.all
    render json: @contracts
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
    params.require(:contract).permit(:user_id, :recipient_id, :content, :status)
  end

  def find_contract
    @contract = Contract.find(params[:id])
  end
end
