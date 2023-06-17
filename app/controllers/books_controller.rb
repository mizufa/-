class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update] #アクセス制限

  def new #投稿機能
    @book = Book.new #Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
  end

  def create #投稿機能
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
    else
    @books = Book.all
    render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.user_id = current_user.id
    if book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(book.id) #各投稿の詳細ページへリダイレクト。
    else
    @book = book
    render :edit
    end
  end

  def index #一覧表示画面
    @book = Book.new #投稿機能。Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @books = Book.all #一覧表示
    #@user = @book.user #特定の投稿（@book）に関連付けられたユーザー情報（.user）を取得し@usersに渡す。
  end

  def show #詳細画面
    @book = Book.find(params[:id])
    @books = Book.new
    @user = User.find(@book.user_id)
  end

  def destroy #削除機能
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path #一覧画面へリダイレクト
  end

  def get_image #画像表示
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

    # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    user_id = book.user
    login_user_id = current_user
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end

end
