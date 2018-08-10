class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.references :user, foreign_key: true
      t.integer :recipient_id
      t.text :content
      t.string :status

      t.timestamps
    end
  end
end
