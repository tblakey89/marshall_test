class UsersController < ApplicationController
  before_filter :signed_in_user, only: [ :edit, :update]
  before_filter :correct_user, only: [ :edit, :update]

  def create
    if session[:auth] == true
      @user = User.new(params[ :user])
      if @user.save
        user_sign_in @user
        redirect_to exam_path(1)
      else
        render 'new'
      end
    else
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[ :id])
  end

  def new
    if session[:auth] == true
      @user = User.new
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    @user = User.find_by_id(params[ :id])
    @user.time_taken = params[ :time_taken]
    @user.score = params[ :score]
    @user.save
    #@user.update_attributes(params[:user])
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to root_path, notice: "Please sign in"
      end
    end

    def correct_user
      @user = User.find(params[ :id])
      redirect_to(root_path) unless current_user? (@user)
    end
end
