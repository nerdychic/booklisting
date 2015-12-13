require 'net/http'
require 'json'

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
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

  def search
    q = 'time' #key words from user input
    uri = URI("https://api.douban.com/v2/book/search?count=10&q=#{q}")
    res = Net::HTTP.get(uri)

    hash = JSON.parse res
    books_from_douban = hash['books']

    @books = []
    books_from_douban.each do |book|
      @books.push(book['title'])
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def correct_user
      @book = current_user.books.find_by(id: params[:id])
      redirect_to books_path, notice: "Not authorized to edit this book" if @book.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:description, :image)
    end
end
