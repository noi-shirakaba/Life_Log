require 'rails_helper'

describe 'EnvironmentControllerAPI' do
  let(:user) { FactoryBot.create(:user, :with_environments) }
  describe "GET /api/v1/environments 環境（situation）を一覧を取得する" do
    it '全てのポストを取得する' do
      get api_v1_environments_path, headers: {
        'Authorization': "Bearer #{user.gwt_token}",
      }
      
      json = JSON.parse(response.body)
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status.to_i).to eq(200)

      # 正しい数のデータが返されたか確認する。
      expect(json.length.to_i).to eq(10)
    end
  end

  describe "GET /api/v1/environments 環境（situation）を詳細を取得する" do
    it '特定のpostを取得する' do
      get api_v1_environment_path(user.environments.first), headers: {
        'Authorization': "Bearer #{user.gwt_token}",
      }
      json = JSON.parse(response.body)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)

      # 要求した特定のポストのみ取得した事を確認する
      expect(json['situation']).to include(user.environments.first.situation)
    end
  end

  describe "POST /api/v1/environments 環境(situation)を新規作成時のテスト" do
    describe "[成功時]　環境（situation）を新規作成する" do
      before do
        @defaultparams = FactoryBot.attributes_for(:environment)
      end

      it '新規作成でデータが1件増える' do
        expect {
          post api_v1_environments_path(format: :json), params:{
            environment: @defaultparams
          }, headers: {
            'Authorization': "Bearer #{user.gwt_token}",
          }
        }.to change(user.environments, :count).by(1)
      end
      it '200が返ってくる' do
        post api_v1_environments_path(format: :json), params:{
          environment: @defaultparams
        }, headers: {
          'Authorization': "Bearer #{user.gwt_token}",
        }
        expect(response).to have_http_status(:success)
        expect(response.status).to eq 200
      end
    end

    describe "[失敗時]　環境(situation)を新規作成する" do
      before do
        @defaultparams = FactoryBot.attributes_for(:environment, situation: "TE")
      end

      it '400が返ってくる' do
        post api_v1_environments_path(format: :json), params:{
          environment: @defaultparams
        }, headers: {
          'Authorization': "Bearer #{user.gwt_token}",
        }
        expect(response.status).to eq 400
      end
    end
  end

  describe "POST /api/v1/environments 環境（situation）を更新する" do
    it 'postの編集を行う' do
      put api_v1_environment_path(user.environments.first), params: { environment: {situation: 'EDIT_TEST_SITUATION'}  }, headers: {
        'Authorization': "Bearer #{user.gwt_token}",
      }
      json = JSON.parse(response.body)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)

      #データが更新されている事を確認
      expect(json['situation']).to include('EDIT_TEST_SITUATION')
      expect(user.environments.first.situation).to include('EDIT_TEST_SITUATION')
    end
  end

  describe "POST /api/v1/environments 環境（situation）を削除する" do
    it 'Environmentレコードが1減る' do
      @post = create(:environment)

      #データが削除されている事を確認
      expect {delete api_v1_environment_path(user.environments.first), headers: {
        'Authorization': "Bearer #{user.gwt_token}",
      }}.to change(user.environments, :count).by(-1)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
  end
end