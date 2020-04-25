class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :applozic_user_id, index: { unique: true }, limit: 150
      t.string :applozic_access_token, index: { unique: true}
      t.string :phone_number, index: { unique: true }
      t.string :email_address, index: { unique: true }
      t.string :email_verification_code
      t.boolean :is_email_verified
      t.string :first_name
      t.string :last_name
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
