class CreatePhones < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
      t.belongs_to :user, index: true
      t.string :number, index: true
      t.string :verification_code
      t.datetime :verification_code_expires_at
      t.timestamps
    end
  end
end
