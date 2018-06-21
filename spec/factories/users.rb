FactoryBot.define do
  factory :user do
    FirstName "aaaaa"
    LastName "bbbbb"
    Age 20
    MailAddress "ccccc@ddddd"
    DeleteFlag 0
	end
	
	factory :firstname_brank do
    #FirstName "aaaaa"
    LastName "bbbbb"
    Age 20
    MailAddress "ccccc@ddddd"
    DeleteFlag 0
	end

	factory :lastname_brank do
    FirstName "aaaaa"
    #LastName "bbbbb"
    Age 20
    MailAddress "ccccc@ddddd"
    DeleteFlag 0
	end

	factory :mailaddress_brank do
    FirstName "aaaaa"
    LastName "bbbbb"
    Age 20
    #MailAddress "ccccc@ddddd"
    DeleteFlag 0
	end

  factory :users_index_1, class: User do
    FirstName "FirstName1"
    LastName "LastName1"
    Age 11
    MailAddress "address@1"
    DeleteFlag 0
  end
  factory :users_index_2, class: User do
    FirstName "FirstName2"
    LastName "LastName2"
    Age 12
    MailAddress "address@2"
    DeleteFlag 0
  end

  factory :takashi, class: User do
	  name "Takashi"
	  email "takashi@example.com"
  end

  factory :satoshi, class: User do
	  name "Satoshi"
	  email "satoshi@example.com"
	end
	
end