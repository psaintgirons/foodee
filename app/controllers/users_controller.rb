class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @filterrific = initialize_filterrific(
      User,
      params[:filterrific]
    ) or return
    @users = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "The #{@user.profile} #{@user.full_name} was created succefully." }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_with_password user_params
        format.html { redirect_to @user, notice: "The #{@user.profile} #{@user.full_name} was updated succefully." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_url, notice: "The #{@user.profile} #{@user.full_name} was deleted succefully." }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end

end