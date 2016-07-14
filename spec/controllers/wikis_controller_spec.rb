require 'rails_helper'
require 'devise'

RSpec.describe WikisController, type: :controller do
  let(:other_user) { create(:user) }
  let(:my_wiki) { create(:wiki) }
  let(:private_wiki) { create(:wiki, private: true) }

  context "unauthenticated user" do

    describe "unauthenticated usere create" do
      it "returns http redirect" do
        new_title = "This is a new Title"
        new_body = "This is a new body for testing. This is a Test"

        put :create, id: my_wiki.id, wiki: { title: new_title, body: new_body }, user_id: nil
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'unauthenticated user update' do
      it "returns http redirect" do
        new_title = "This is a new Title update"
        new_body = "This is a new body for updating."

        put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body }, user_id: nil
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

    describe "authenticate user create" do
      it "returns http redirect" do
        new_title = "This is a new Title"
        new_body = "This is a new body for test"

        put :create, id: my_wiki.id, wiki: { title: new_title, body: new_body }, user_id: @my_user.id
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "authenticated user update" do
      it "returns http redirect" do
        new_title = "This is a new title update"
        new_body = "This is a new body for updating"

        put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body }, user_id: @my_user.id
        expect(response).to redirect_to("http://test.host/wikis/#{my_wiki.title.downcase}") 
      end
    end
  end
end
