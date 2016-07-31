require 'rails_helper'
require 'devise'

RSpec.describe WikisController, type: :controller do
  let(:other_user) { create(:user) }
  let(:my_wiki) { create(:wiki) }
  let(:private_wiki) { create(:wiki, private: true) }

  context "unauthenticated user" do

    describe "index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "show" do
      it "returns http redirect" do
        get :show, {id: my_wiki.id}
        expect(flash[:alert]).to be_nil
        expect(response).to redirect_to(root_path)
      end
    end

    describe "new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "create" do
      it "returns http redirect" do
        new_title = "This is a new Title"
        new_body = "This is a new body for testing. This is a Test"

        put :create, id: my_wiki.id, wiki: { title: new_title, body: new_body }, user_id: nil
        expect(flash.now[:alert]).to_not be_nil
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "edit" do
      it "returns http redirect" do
        get :edit, {id: my_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'update' do
      it "returns http redirect" do
        new_title = "This is a new Title update"
        new_body = "This is a new body for updating."

        put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body }, user_id: nil
        expect(flash.now[:alert]).to_not be_nil
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "destroy" do
      it "returns http redirect" do
        delete :destroy, {id: my_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  context "authenticated user" do
    before :each do
      @my_user = FactoryGirl.create(:user)
      controller.stub(:authenticate_user!).and_return(true)
      controller.stub(:current_user).and_return(@my_user)
    end

    describe "create" do
      it "returns http redirect" do
        new_title = "This is a new Title"
        new_body = "This is a new body for test"

        put :create, id: my_wiki.id, wiki: { title: new_title, body: new_body }, user_id: @my_user.id
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "update" do
      it "returns http redirect" do
        new_title = "This is a new title update"
        new_body = "This is a new body for updating"

        put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body }, user_id: @my_user.id
        expect(response).to redirect_to("http://test.host/wikis/#{my_wiki.title.downcase}")
      end
    end
  end

  describe ".user_not_authorized" do
    it "it passes" do
      @user = nil
      @controller = WikisController.new
      expect(@controller).to receive(:user_not_authorized)
      @controller.send(:user_not_authorized)
    end
  end
end
