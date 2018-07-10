require 'rails_helper'

RSpec.describe 'Users', type: :request do

  describe 'GET /api/users/:id' do
    context '正常系' do
      before do
        @user = create(:user)
        get '/api/users' + '/' + @user[:id].to_s
      end

      it '200応答確認' do
        expect(response).to be_successful
        expect(response.status).to eq 200
      end

      it '取得データ確認' do
        @json = JSON.parse(response.body)
        expect(@json['FirstName']).to eq 'aaaaa'
        expect(@json['LastName']).to eq 'bbbbb'
        expect(@json['Age']).to eq 20
        expect(@json['MailAddress']).to eq 'ccccc@ddddd'
        expect(@json['DeleteFlag']).to eq 0
      end
    end

    context '異常系' do
      before do
        get '/api/users' + '/' + '1'
      end 
 
      it '404応答確認' do
        expect(response.status).to eq 404
      end
    end
  end
 
  describe 'GET /api/users' do
    context '正常系' do
      before do
        create(:users_index_1)
        create(:users_index_2)
        get '/api/users'
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
  end
 
  describe 'POST /api/users' do
    context '正常系' do
      it '201応答確認' do
        post '/api/users', params: { user: attributes_for(:user) }
        expect(response).to be_successful
        expect(response.status).to eq 201
        #expect(response.location).to eq 999
        #got: "http://www.example.com/api/users.1" usersの後ろがスラッシュではなくピリオドになっている
      end
 
      it 'Userレコード登録確認' do
        expect { post '/api/users', params: { user: attributes_for(:user) } }.to change(User, :count).by(1)
      end
    end

    context '異常系' do
      it '400応答確認' do
        #パラメータチェック FirstName
        post '/api/users', params: { firstname_brank: attributes_for(:user) }
        expect(response.status).to eq 400

        #パラメータチェック LastName
        post '/api/users', params: { lastname_brank: attributes_for(:user) }
        expect(response.status).to eq 400 

        #パラメータチェック MailAddress
        post '/api/users', params: { mailaddress_brank: attributes_for(:user) }
        expect(response.status).to eq 400
      end
 
      it '409応答確認' do      
        post '/api/users', params: { user: attributes_for(:user) }
        expect(response.status).to eq 201
        post '/api/users', params: { user: attributes_for(:user) }
        expect(response.status).to eq 409
      end
    end
  end
 
  describe 'PUT /api/users/:id' do
    context '正常系' do
      let(:users_index_1) { create :users_index_1 }
 
      it '200応答確認' do
        put '/api/users' + '/' + users_index_1.id.to_s, params: { id: users_index_1, user: attributes_for(:users_index_2) }
        expect(response.status).to eq 200
      end
 
      it 'Userレコード更新確認' do
        expect do
          put '/api/users' + '/' + users_index_1.id.to_s, params: { id: users_index_1, user: attributes_for(:users_index_2) }
        end.to change { User.find(users_index_1.id).FirstName }.from('FirstName1').to('FirstName2')
      end
    end
 
    context '異常系' do
      it '404応答確認' do
        put '/api/users' + '/' + '1', params: { id: 1, user: attributes_for(:users_index_2) }
        expect(response.status).to eq 404
      end
    end
  end
 
  describe 'DELETE /api/users/:id' do
    context '正常系' do
      let(:users_index_1) { create :users_index_1 }
 
      it '200応答確認' do
        delete '/api/users' + '/' + users_index_1.id.to_s
        expect(response.status).to eq 200
      end
 
      it 'Userレコード更新確認' do
        expect do
          delete '/api/users' + '/' + users_index_1.id.to_s
        end.to change { User.find(users_index_1.id).DeleteFlag }.from(0).to(1)
      end
    end
 
    context '異常系' do
      it '404応答確認' do
        delete '/api/users' + '/' + '1'
        expect(response.status).to eq 404  
      end
    end
  end
end