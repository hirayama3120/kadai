class CreateUsers < ActiveRecord::Migration[5.2]
    def change
      create_table :users do |t|
        t.string :FirstName
        t.string :LastName
        t.integer :Age
        t.string :MailAddress
        t.integer :DeleteFlag, default: 0
        
        t.timestamps
      end
    end
  end
  