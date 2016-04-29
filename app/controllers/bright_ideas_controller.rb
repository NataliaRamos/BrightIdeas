class BrightIdeasController < ApplicationController

  def index
    @current_user = session[:user_id]
    @user = User.find(session[:user_id])
    @bright_ideas = BrightIdea.all.sort{|x,y| y.likes.count <=> x.likes.count}
    # @bright_ideas = BrightIdea.joins(:likes).group("bright_ideas.id").order("count_id DESC").count(:id).map{|k,v|BrightIdea.find(k)}
  end

  def show
    @user = User.find(session[:user_id])
    @bright_idea = BrightIdea.find(params[:id])
    @likes = @bright_idea.users.distinct
  end

  def create
    @current_user = session[:user_id]
    bright_idea = BrightIdea.new(content: bright_idea_params['content'], user_id: @current_user)
    if bright_idea.save
      flash["success"] = "New Bright Idea!"
      redirect_to "/bright_ideas"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/bright_ideas"
      end
  end

  def destroy
    bright_idea = BrightIdea.find(params[:id]).delete
    redirect_to "/bright_ideas"
  end

   private
  def bright_idea_params
    params.require(:bright_idea).permit(:content)
  end
end
