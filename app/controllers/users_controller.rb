class UsersController < ApplicationController
		before_action :authenticate_user!
	def show
		@user = User.find(params[:id])
		@books = @user.books.all
		@book = @user.books.new
	end
	def index
		@users = User.all
		@book = Book.new
		@user = current_user
	end
	def edit
	    @user = User.find(params[:id])
	    @book = Book.new
	    @books = @user.books.all
	    if @user != current_user
	    	redirect_to user_path(current_user)
	    end
	end
	def update
		@user = User.find(params[:id])
		  if @user.update(user_params)
		  	flash[:notice] = "User was successfully updated."
		     redirect_to user_path(@user)
		  else
		  	@book = Book.new
		  	@books = @user.books.all
		  	render :edit
		  end
	end
	private
	def user_params
		params.require(:user).permit(:profile_image,:introduction,:name)
	end
end
