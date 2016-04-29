class LikesController < ApplicationController
  def create
    user = session[:user_id]
  	bright_idea = BrightIdea.find(params[:bright_idea_id])
  	like = Like.create(user_id: user, bright_idea_id: params[:bright_idea_id])
  	redirect_to '/bright_ideas'
  end
end
