require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /api/users/:id" do
    before do
      @user = FactoryBot.create(:user)
      get "/api/users" + "/" + @user[:id].to_s
      @json = JSON.parse(response.body)
    end

    it '200応答チェック' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it '取得データチェック' do
      expect(@json["FirstName"]).to eq "aaaaa"
      expect(@json["LastName"]).to eq "bbbbb"
      expect(@json["Age"]).to eq 20
      expect(@json["MailAddress"]).to eq "ccccc@ddddd"
      expect(@json["DeleteFlag"]).to eq 0
    end
  end
end

RSpec.describe "Users", type: :request do
  describe "GET /api/users" do
    before do
      FactoryBot.create(:users_index_1)
      FactoryBot.create(:users_index_2)
    end
    it '200応答チェック' do
      get "/api/users"
      expect(response.status).to eq 200

      json = JSON.parse(response.body)
       expect(User.count).to eq json.count
    end
  end
end

#describe "POST /api/users" do
#  before do
#    #@params = FactoryBot.attributes_for(:users_create)
#    @params = FactoryBot.create(:users_create)
#  end
#
#  it '200応答チェック' do
#    #post "/api/users", :user @params, :FirstName @params[:FirstName], :LastName @params[:LastName], :Age @params[:Age], :MailAddress @params[:MailAddress]
#    post "/api/users", user: @params
#    expect(response).to be_success
#    expect(response.status).to eq 200
#  end
#
#  it 'Userレコードが1増える' do
#    expect { post api_users_path, @params }.to change(User, :count).by(1)
#  end
#end


RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe 'Post #create' do
    let(:param) do
      {
        users: {
          FirstName: "aaaaa",
          LastName: "bbbbb",
          Age: 20,
          MailAddress: "ccccc@ddddd"
        }
      }
    end

    context 'when send correct parameters' do
      let(:http_response) do
        post "/api/users", params: param
      end

      it 'responds status "200 OK"' do
        expect(response.status).to eq 200
      end
    end
  end
end