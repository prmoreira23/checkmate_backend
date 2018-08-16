class CreateContractPdfs < ActiveRecord::Migration[5.2]
  def change
    create_table :contract_pdfs do |t|

      t.timestamps
    end
  end
end
