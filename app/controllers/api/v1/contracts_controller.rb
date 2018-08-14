class Api::V1::ContractsController < ApplicationController

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
    params.require(:contract).permit(:user_id, :recipient_id, :content, :status)
  end

  def find_contract
    @contract = Contract.find(params[:id])
  end
end
