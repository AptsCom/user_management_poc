class UsersController < ApplicationController
  def create
  	#render text: params[:user].inspect
  	@user = User.create!(params[:user].permit(:first_name, :last_name, :email))
  	redirect_to(@user)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end
end
