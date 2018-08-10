class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.references :user, foreign_key: true
      t.references :contract, foreign_key: true
      t.string :action_type
      t.string :action_hash
      t.string :previous_hash

      t.timestamps
    end
  end
end
