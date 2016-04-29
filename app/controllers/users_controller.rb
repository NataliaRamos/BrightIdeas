class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @bright_ideas = BrightIdea.where(user: @user)
    @likes = Like.where(user: @user)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/bright_ideas"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/sessions"
      end
  end

  private
    def user_params
      params.require(:user).permit(:name, :alias, :email,  :password, :password_confirmation)
    end
end
