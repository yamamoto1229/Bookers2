class BooksController < ApplicationController
	before_action :authenticate_user!, except: [:home,:about]
	def show
		@book = Book.find(params[:id])
		@user = @book.user
	end
	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end
	def new
		@books = Book.new
	end
	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		  if @book.save
		  	flash[:notice] = "Book was successfully created."
		    redirect_to book_path(@book.id)
		  else
		  	@user = current_user
		  	@books = Book.all
		  	render :index
		  end
	end
	def edit
		@book = Book.find(params[:id])
		if @book.user != current_user
			redirect_to books_path
		end
	end
	def update
		@book = Book.find(params[:id])
		  if @book.update(book_params)
		  	flash[:notice] = "Book was successfully updated."
		     redirect_to book_path(@book)
		  else
		  	render :edit
		  end
	end
	def destroy
		book = Book.find(params[:id])
		book.destroy
		 if book.destroy
		 	redirect_to books_path
		 else
		    redirect_to books_path
		 end
	end
	def about
	end
	def home
		if user_signed_in?
			@user = current_user
			
		end
	end
	private
	def book_params
		params.require(:book).permit(:title, :category, :body)
	end
end
