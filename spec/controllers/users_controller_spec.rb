require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let!(:user){FactoryBot.create :user, id: Settings.id_user1}

  describe "Not login" do
    context "GET #show" do
      before {get :show, params: {id: Settings.id_user1}}

      it "redirect to login page" do
        expect(response).to redirect_to(login_path)
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end

    context "GET #new" do
      before {get :new}

      it "render signup page" do
        expect(response).to render_template(:new)
      end

      it "assigns @user" do
        expect(assigns(:user)).to be_a_new(User)
      end

      it "should be success" do
        expect(response).to have_http_status(200)
      end
    end

    context "POST #create" do
      before {post :create, params: { user: FactoryBot.attributes_for(:user).merge(email: "abcxyz@gmail.com")} }

      it "create success" do
        expect(User.last.email).to eq("abcxyz@gmail.com")
      end

      it "test number of user" do
        expect{
          post :create, params: {user: FactoryBot.attributes_for(:user).merge(email: "abcxyz1@gmail.com")}
        }.to change(User, :count).by(1)
      end

      it "redirect_to the home page" do
        expect(response).to redirect_to(root_url)
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end

    context "create user failed" do
      before do
        post :create, params: {id: user.id, user: FactoryBot.attributes_for(:user)}
      end

      it "create user failed" do
        expect(flash[:danger]).to match(I18n.t("fail_sign_up"))
        expect(response).to render_template(:new)
      end
    end

    context "GET #edit" do
      before {get :edit, params: {id: Settings.id_user1}}

      it "redirect to login page" do
        expect(response).to redirect_to(login_path)
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end

    context "PATCH #update" do
      before {patch :update, params: {id: Settings.id_user1}}

      it "redirect to login page" do
        expect(response).to redirect_to(login_path)
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "Login with user" do
    let!(:user){FactoryBot.create :user, id: Settings.id_user2, role: Settings.role_user}

    before do
      logged_in user
    end

    context "GET #show" do
      before do
        get :show, params: {id: user.id}
      end

      it "render show template" do
        expect(response).to render_template(:show)
      end

      it "should be success" do
        expect(response).to have_http_status(200)
      end
    end

    context "GET #edit" do
      before do
        get :edit, params: {id: user.id}
      end

      it "render edit template" do
        expect(response).to render_template(:edit)
      end

      it "should be success" do
        expect(response).to have_http_status(200)
      end
    end

    context "PATCH #update" do
      before do
        patch :update, params: {id: user.id, user: FactoryBot.attributes_for(:user).merge(name: "user123")}
      end

      it "redirect to @user" do
        expect(response).to redirect_to(user)
      end

      it "update success" do
        expect(flash[:success]).to match(I18n.t("user_updated"))
        expect(user.reload.name).to eq("user123")
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end
  end
end
