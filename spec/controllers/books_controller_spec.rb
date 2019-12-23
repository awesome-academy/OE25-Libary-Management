require "rails_helper"

RSpec.describe Admin::BooksController, type: :controller do
  let!(:author){FactoryBot.create :author}
  let!(:publisher){FactoryBot.create :publisher}
  let!(:category){FactoryBot.create :category}
  let!(:book){FactoryBot.create :book, author_id: author.id, publisher_id: publisher.id, category_id: category.id }

  describe "not admin" do
    let!(:user){FactoryBot.create :user, role: Settings.enum_user}
    before do
      logged_in user
    end

    context "GET #index" do
      before do
        get :index
      end

      it "redirect to home" do
        expect(response).to redirect_to(root_path)
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end

    context "GET #show" do
      before do
        get :show, params: {id: book.id}
      end

      it "redirect to home" do
        expect(response).to redirect_to(root_path)
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end

    context "GET #edit" do
      before do
        get :edit, params: {id: book.id}
      end

      it "redirect to home" do
        expect(response).to redirect_to(root_path)
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end

    context "GET #new" do
      before { get :new }

      it "redirect to home" do
        expect(response).to redirect_to(root_path)
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end

    context "POST #create" do
      before do
        post :create
      end

      it "redirect to home" do
        expect(response).to redirect_to(root_path)
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end

    context "PATCH #update" do
      before do
        patch :update, params: {id: book.id}
      end

      it "redirect to home" do
        expect(response).to redirect_to(root_path)
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end

    context "DELETE #destroy" do
      before do
        delete :destroy, params: {id: book.id}
      end

      it "redirect to home" do
        expect(response).to redirect_to(root_path)
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "Login admin" do
    let!(:user){FactoryBot.create :user,role: Settings.enum_admin}
    before do
      logged_in user
    end

    context "GET #index" do
      before do
        get :index
      end

      it "returns a success response" do
        expect(response).to have_http_status(200)
      end

      it "assigns @books" do
        expect(assigns(:books)).to eq [book]
      end

      it "renders the index template" do
        expect(response).to render_template :index
      end

      it "generate the same route" do
        should route(:get, 'admin/books').to(action: :index)
      end
    end

    context "GET #show" do
      before do
        get :show, params: {id: book.id}
      end

      it "returns a success response" do
        expect(response).to have_http_status(200)
      end

      it "assigns @books" do
        expect(assigns(:book)).to eq book
      end

      it "before action find book" do
        should use_before_action(:find_book)
      end

      it "generate the same route" do
        should route(:get, "admin/books/#{book.id}").to(action: :show, id: book.id)
      end
    end

    context "GET #edit" do
      before do
        get :edit, params: {id: book.id}
      end

      it "render edit template" do
        expect(response).to render_template(:edit)
      end

      it "assigns @book" do
        expect(assigns(:book)).to eq book
      end

      it "before action find book" do
        should use_before_action(:find_book)
      end

      it "generate the same route" do
        should route(:get, "admin/books/#{book.id}/edit").to(action: :edit, id: book.id )
      end
    end

    context "GET #new" do
      before do
        get :new
      end

      it "should be success" do
        expect(response).to have_http_status(200)
      end

      it "render new template" do
        expect(response).to render_template(:new)
      end

      it "new book" do
        expect(assigns(:book)).to be_a_new(Book)
      end

      it "before action find book" do
        should use_before_action(:find_book)
      end

      it "generate the same route" do
        should route(:get, "admin/books/new").to(action: :new)
      end
    end

    describe "POST #create" do
      context "success create" do
        before do
          post :create, params: {book: FactoryBot.attributes_for(:book).merge(author_id: author.id, publisher_id: publisher.id, category_id: category.id) }
        end

        it "should found" do
          expect(response).to have_http_status(302)
        end

        it "redirect to books" do
          expect(response).to redirect_to admin_book_path(Book.last)
        end

        it "create successfull" do
          expect(assigns(:book)).to eq(Book.last)
        end

        it "test number of user" do
          expect{
            post :create, params: {book: FactoryBot.attributes_for(:book).merge(author_id: author.id, publisher_id: publisher.id, category_id: category.id) }
          }.to change(Book, :count).by(1)
        end
      end

      context "fail create" do
        before do
          post :create, params: {book: FactoryBot.attributes_for(:book).merge(publisher_id: publisher.id, category_id: category.id) }
        end

        it "should found" do
          expect(response).to have_http_status(200)
        end

        it "create book failed" do
          expect(flash[:danger]).to match(I18n.t("create_book_fail"))
        end

        it "render new template" do
          expect(response).to render_template(:new)
        end
      end
    end

    describe "PATCH #update" do
      context "update success" do
        before do
          patch :update, params: {id: book.id, book: {name: "Name Book", price: 200000, rest_amount: 200}}
        end

        it "should found" do
          expect(response).to have_http_status(302)
        end

        it "redirect to book index" do
          expect(response).to redirect_to admin_book_path(book)
        end

        it "before action find book" do
          should use_before_action(:find_book)
        end

      end

      context "update fail" do
        before do
          patch :update, params: {id: book.id, book: {name: "", price: "", rest_amount: 200}}
        end

        it "should found" do
          expect(response).to have_http_status(200)
        end

        it "render edit template" do
          expect(flash[:danger]).to match(I18n.t("edit_fail"))
        end

        it "before action find book" do
          should use_before_action(:find_book)
        end

      end
    end

    describe "DELETE #destroy" do
      context "destroy success" do
        before do
          delete :destroy, params: {id: book.id}
        end

        it "should found" do
          expect(response).to have_http_status(302)
        end

        it "redirect to book index" do
          expect(response).to redirect_to(admin_books_path)
        end

        it "before action find book" do
          should use_before_action(:find_book)
        end

        it "render flash success" do
          expect(flash[:success]).to match(I18n.t("delete_book_success"))
        end

        it "generate the same route" do
          should route(:delete, "admin/books/#{book.id}").to(action: :destroy, id: book.id)
        end
      end

      context "destroy fail" do
        before do
          delete :destroy, params: {id: book.id}
        end

        it "should found" do
          expect(response).to have_http_status(302)
        end

        it "before action find book" do
          should use_before_action(:find_book)
        end

        it "generate the same route" do
          should route(:delete, "admin/books/#{book.id}").to(action: :destroy, id: book.id)
        end
      end
    end

    context "PATCH #update" do
      before do
        log_in @user
        patch :update, params: {id: 1, book: {name: "Name Book"}}
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end

      it "redirect to book index" do
        expect(response).to redirect_to admin_book_path(book)
      end

      it { should use_before_action(:find_book) }

      it { should_not use_before_action(:prevent_ssl) }

      it "generate the same route" do
        should route(:patch, 'admin/books/1').to(action: :update, id: 1)
      end
    end

    context "DELETE #destroy" do
      before do
        log_in @user
        delete :destroy, params: {id: 1}
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end

      it "redirect to book index" do
        expect(response).to redirect_to(admin_books_path)
      end

      it "generate the same route" do
        should route(:delete, 'admin/books/1').to(action: :destroy, id: 1)
      end
    end
  end
end
