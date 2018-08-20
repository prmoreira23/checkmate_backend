class AddContractHashToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :contract_hash, :string
  end
end
