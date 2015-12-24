class CommentsController < ApplicationController
	before_action :authenticate_user!

	def index 
	end

	def create
		#@comment = @commentable.comments.new comment_params
		#@book = Book.find(params[:book_id])
		@book = Book.find(params[:comment][:book_id])
		@comment = @book.comments.new comment_params
		@comment.user_id = current_user.id
		@comment.save
		redirect_to @book, notice: "Your comment was successfully posted."
	end

private
	def comment_params
		params.require(:comment).permit(:body, :book_id)
	end
end