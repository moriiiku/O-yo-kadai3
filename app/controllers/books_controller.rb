class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    @booknew = Book.new
  	@book = Book.find(params[:id])
    @user = @book.user
    @books = Book.all
    @post_comment = PostComment.new
  end

  def new
    @booknew = Book.new
  end

  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @user = current_user
    @booknew = Book.new

  end

  def create
  	@booknew = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @booknew.user_id = current_user.id
  	if @booknew.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@booknew), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
      @user = current_user
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end

def destroy
  @book = Book.find(params[:id])
  @book.destroy
  redirect_to books_path
end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def delete
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_user
    unless Book.find(params[:id]).user == current_user
      redirect_to books_path
    end
  end

end
