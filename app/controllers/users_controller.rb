class UsersController < ApplicationController
    # Fill from devise
    # http://rails-3-2.railstutorial.org/book/_single-page#_table-RESTful_users
  def new
      redirect_to new_user_registration_path
  end
  def index
      @users = User.paginate(page: params[:page])
      respond_to do |format|
        format.html
        format.doc
      end
  end
  def show
      @user = User.find(params[:id])
      @questions = @user.questions.paginate(page: params[:page])
  end
end
