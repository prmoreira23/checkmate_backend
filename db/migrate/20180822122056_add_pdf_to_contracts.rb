class AddPdfToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :pdf, :string
  end
end
