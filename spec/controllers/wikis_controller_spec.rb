require 'rails_helper'
require 'devise'

RSpec.describe WikisController, type: :controller do
  let(:other_user) { create(:user) }
  let(:my_wiki) { create(:wiki) }
  let(:private_wiki) { create(:wiki, private: true) }

  context "unauthenticated user" do
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "does not include private wikis" do
        get:index
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
        post :create, wiki: { title: "New Wiki", body: "This is a new body", user: @my_user }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, { id: my_wiki.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = "New Title"
        new_body = "This is a new body."

        put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, { id: my_wiki.id }
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
        post :create, wiki: { title: "New Wiki", body: "This is a new body", user: @my_user }
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, { id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = "New Title"
        new_body = "This is a new body."

        put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body }
        expect(response).to redirect_to(wiki_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, { id: my_wiki.id }
        expect(response).to redirect_to(wikis_path)
      end
    end
  end

  context "admin user" do
    before :each do
      @my_user = FactoryGirl.create(:user)
      controller.stub(:authenticate_user!).and_return(true)
      controller.stub(:current_user).and_return(@my_user)
      @my_user.role == "admin"
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
        post :create, wiki: { title: "New Wiki", body: "This is a new body", user: @my_user }
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, { id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = "New Title"
        new_body = "This is a new body."

        put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body }
        expect(response).to redirect_to(wiki_path)
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
