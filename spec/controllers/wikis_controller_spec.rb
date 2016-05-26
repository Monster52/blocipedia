require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:my_wiki) { create(:wiki) }
  let(:private_wiki) { create(:wiki, private: true) }

  context "authenticated user" do
    before(:each) do
      login_as other_user
    end

    after(:each) do
      Warden.test_reset!
    end

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns Wiki.all to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([my_wiki])
      end

      it "does not include private wikis" do
        get :index
        expect(assigns(:wikis)).not_to include(:private_wiki)
      end
    end

    describe "GET show" do
      it "redirects from private wikis" do
        get :show, { id: private_wiki.id }
        expect(response).to redirect_to(root_path)
      end

      it "returns http success" do
        get :show, { id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, { id: my_wiki.id }
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, { id: my_wiki.id }
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, wiki: { title: "New Wiki", body: "This is a new body", user: my_user }
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, { id: my_wiki.id }
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = "New Title"
        new_body = "This is a new body."

        put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body }
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, { id: my_wiki.id }
        expect(response).to redirect_to(wikis_path)
      end
    end
  end
end
