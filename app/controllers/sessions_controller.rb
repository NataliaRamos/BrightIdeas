class SessionsController < ApplicationController
  def index
  end

  def new
    if session[:id]
      redirect_to "/bright_ideas"
    end
  end

  def create
      user = User.find_by_email(params[:email])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to "/bright_ideas"
      else
        flash[:errors] = ["Invalid combination"]
        redirect_to "/sessions"
      end
  end

  def destroy
      session[:user_id] = nil
      redirect_to "/sessions"
    end
end
