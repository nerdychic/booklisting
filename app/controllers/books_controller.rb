class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :correct_user, only: [:edit, :update, :destroy,:upvote]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_commentable, only: [:show]
 
 require 'net/http'
  # GET /books
  # GET /books.json
  def index
    @books = Book.all.order("created_at DESC").paginate(:page => params[:page],:per_page => 5)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = current_user.books.build
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = current_user.books.build(book_params)
      if @book.save
        redirect_to @book, notice: 'Book was successfully created.' 
       
      else
         render :new 
      end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    #@book = current_user.books.build(book_params)
    puts "*********************************************"
    puts @book.name
    puts @book.collections
    puts book_params
    puts "*********************************************"

      if @book.update(book_params)
        redirect_to @book, notice: 'Book was successfully updated.' 
      else
        render :edit 
      end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
      redirect_to books_url, notice: 'Book was successfully destroyed.' 
  end

  def upvote
    @book.upvote_by current_user
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def set_commentable
      @comments = Comment.where(book_id: params[:id])
    end

  def correct_user
      @book = current_user.books.find_by(id: params[:id])
      redirect_to books_path, notice: "Not authorized to edit this book" if @book.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:description, :image, :name, :author, :collection_ids =>[])
      # params.require(:collection).permit(:name,{collection_ids:[]})
    end

end
