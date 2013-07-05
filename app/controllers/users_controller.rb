class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    if signed_in?
      @micropost = current_user.microposts.build
    end
    @microposts = @user.microposts
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      # flash[:success] = "Welcom to MicroPosts.com!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @good = params[:good]
    if @good == "true"
      current_user.he_is_good!(@user)
    else
      current_user.he_is_bad!(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  def showall
    @users = User.all
  end

  def index
    @users = User.all
  end

end
