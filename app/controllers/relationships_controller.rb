class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @title = params[:title]
    @user = User.find_by id: params[:user_id]
    if @user
      @users = @user.send(@title).paginate page: params[:page]
      render "users/show_follow"
    else
      flash[:danger] = t ".danger"
      redirect_to @user
    end
  end

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    @unfollow = current_user.active_relationships.find_by followed_id: @user.id
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    @follow = current_user.active_relationships.build
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
