require 'rails_helper'

describe "ActionsControllerAPI" do
  let(:user) { FactoryBot.create(:user) }
  let(:environment) { FactoryBot.create :environment }
  describe "[成功時]　行動（action）を新規作成する" do
    before do
      @defaultparams = FactoryBot.attributes_for(:action, environment_id: environment.id)
    end
    it '新規作成でデータが1件増える' do
      expect {
        post api_v1_actions_path(format: :json), params:{
          id: @defaultparams[:environment_id],
          action_category: [@defaultparams[:action_category]]
        }, headers: {
          'Authorization': "Bearer #{user.gwt_token}",
        }
      }.to change(Action, :count).by(1)
    end
    it '200が返ってくる' do
      post api_v1_actions_path(format: :json), params:{
        id: @defaultparams[:environment_id],
        action_category: [@defaultparams[:action_category]]
      }, headers: {
        'Authorization': "Bearer #{user.gwt_token}",
      }
      expect(response).to have_http_status(:success)
      expect(response.status).to eq 200
    end
  end

  describe "[失敗時]　行動（action）を新規作成する" do
    before do
      @defaultparams = FactoryBot.attributes_for(:action, action_category: "TE", environment_id: environment.id)
    end

    it '400が返ってくる' do
      post api_v1_actions_path(format: :json), params:{
        id: @defaultparams[:environment_id],
        action_category: [@defaultparams[:action_category]]
      }, headers: {
        'Authorization': "Bearer #{user.gwt_token}",
      }
      expect(response.status).to eq 400
    end
  end
end