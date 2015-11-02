class UsersController < ApplicationController
    # Fill from devise
    # http://rails-3-2.railstutorial.org/book/_single-page#_table-RESTful_users
  def new
      redirect_to new_user_registration_path
  end
  def index
      @users = User.paginate(page: params[:page])
  end
  def show
      @user = User.find(params[:id])
  end
end
