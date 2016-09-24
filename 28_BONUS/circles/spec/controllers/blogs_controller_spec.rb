require 'rails_helper'

describe BlogsController do

  context "not logged in" do
    it "should be redirect to login page" do
      get :edit, id: 1
      expect(response).to redirect_to(new_session_path)
    end
  end

  context "logged in" do
    before(:each) do
      @user = create_user
      signin_user @user

      @blog = @user.blogs.create(title: "test blog", content: "test content")
    end

    it "#edit" do
      get :edit, id: @blog.id
      expect(response).to render_template(:new)
    end

    context '#update' do
      it "should fail" do
        put :update, id: @blog.id, blog: { title: "" }
        expect(assigns(:blog).valid?).to be false
        expect(response).to render_template(:new)
      end

      it "should success" do
        put :update, id: @blog.id, blog: { title: "new title", content: "new content" }
        expect(assigns(:blog).valid?).to be true
        expect(response).to redirect_to(blogs_path)
      end 
    end

    context "#update by correct way" do
      it "should fail" do
        expect(@blog).to receive(:save).and_return(false)
        expect(controller).to receive_message_chain(:current_user, :blogs, :find).and_return(@blog)

        put :update, id: @blog.id, blog: { title: "test" }
        expect(response).to render_template(:new)
      end

      it "should success" do
        expect(@blog).to receive(:save).and_return(true)
        expect(controller).to receive_message_chain(:current_user, :blogs, :find).and_return(@blog)

        put :update, id: @blog.id, blog: { title: "" }
        expect(response).to redirect_to(blogs_path)
      end
    end
  end

end