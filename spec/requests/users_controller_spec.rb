require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:user) { create(:user) }
  let(:valid_params) { attributes_for(:user, password_confirmation: 'password') }
  let(:invalid_params) { attributes_for(:user, password_confirmation: 'bar') }

  describe "GET /users" do
    context 'all users' do
      before do
        get users_path
      end

      it 'should be success' do
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'GET /signup' do
    context 'logged in user' do
      before do
        log_in_as(user)
        get new_user_path
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end

    context 'non logged in user' do
      before do
        # log_in_as(user)
        get new_user_path
      end

      it 'should be success' do
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'POST /users' do
    context 'valid params' do
      before do
        # log_in_as(user)
        post users_path, params: { user: valid_params }
      end

      it 'redirect to user page' do
        expect(response).to have_http_status 302
      end

      it 'user count +1' do
        expect(User.count).to eq 1
      end
    end

    context 'invalid params' do
      before do
        # log_in_as(user)
        post users_path, params: { user: invalid_params }
      end

      it 'status is 422' do
        expect(response).to have_http_status 422
      end

      it 'render :new' do
        expect(response).to render_template :new
      end
    end

    context 'logged in user' do
      before do
        log_in_as(user)
        post users_path, params: { user: valid_params }
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET /users/:name' do
    before do
      get user_path(user)
    end

    it 'should be success' do
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /settings/user' do
    context 'logged in user' do
      before do
        activate_as(user)
        get edit_user_path()
      end

      it 'should be success' do
        expect(response).to have_http_status 200
      end
    end

    context 'non logged in user' do
      before do
        activate_as(user)
        log_out_as(user)
        get edit_user_path()
      end

      it 'should redirect user page' do
        expect(response).to redirect_to new_session_path
      end
    end

    context 'non activate user' do
      before do
        log_in_as(user)
        get edit_user_path()
      end

      it 'should redirect activation form' do
        expect(response).to redirect_to new_account_activation_path
      end
    end
  end

  describe 'PATCH /users/:name' do
    context 'valid params' do
      before do
        activate_as(user)
        patch user_path(user), params: { user: valid_params }
      end

      it 'should redirect to user page' do
        expect(response).to redirect_to user.reload
      end
    end

    context 'invalid params' do
      before do
        activate_as(user)
        patch user_path(user), params: { user: invalid_params }
      end

      it 'render :edit' do
        expect(response).to render_template :edit
      end
    end

    context 'non logged in user' do
      before do
        activate_as(user)
        log_out_as(user)
        patch user_path(user), params: { user: valid_params }
      end

      it 'redirect to login page' do
        expect(response).to redirect_to new_session_path
      end
    end

    context 'non activate user' do
      before do
        log_in_as(user)
        patch user_path(user), params: { user: valid_params }
      end

      it 'should redirect activation form' do
        expect(response).to redirect_to new_account_activation_path
      end
    end
  end

  describe 'DELETE /users/:name' do
    context 'logged in user' do
      before do
        log_in_as(user)
        delete user_path(user)
      end

      it 'should delete user' do
        expect(User.count).to eq 0
      end
    end

    context 'non logged in user' do
      before do
        # log_in_as(user)
        delete user_path(user)
      end

      it 'should redirect to root' do
        expect(response).to redirect_to new_session_path
      end
    end
  end
end