class UsersController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update] #アクセス制限


  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(current_user.id) #ユーザーの投稿一覧ページへリダイレクト。
    else
      @user = user
      render :edit
    end
  end

  def index #ユーザーの一覧画面
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def get_image #画像表示
  end



  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
