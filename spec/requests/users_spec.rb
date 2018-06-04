require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /api/users/:id" do
    before do
      @user = create(:user)
      get "/api/users" + "/" + @user[:id].to_s
    end

    it '200応答確認' do
      expect(response).to be_successful
      expect(response.status).to eq 200
    end

    it '取得データ確認' do
      @json = JSON.parse(response.body)
      expect(@json["FirstName"]).to eq "aaaaa"
      expect(@json["LastName"]).to eq "bbbbb"
      expect(@json["Age"]).to eq 20
      expect(@json["MailAddress"]).to eq "ccccc@ddddd"
      expect(@json["DeleteFlag"]).to eq 0
    end
  end

  describe "GET /api/users" do
    before do
      create(:users_index_1)
      create(:users_index_2)
      get "/api/users"
    end

    it '200応答確認' do
      expect(response).to be_successful
      expect(response.status).to eq 200
    end

    it '取得件数確認' do
      @json = JSON.parse(response.body)
      expect(User.count).to eq @json.count
    end
  end

  describe "POST /api/users" do
    it '200応答確認' do
      post "/api/users", params: { user: attributes_for(:user) }
      expect(response).to be_successful
      expect(response.status).to eq 200
    end

    it 'Userレコード登録確認' do
      expect { post "/api/users", params: { user: attributes_for(:user) } }.to change(User, :count).by(1)
    end
  end


end