class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    return notification unless @user
    current_user.follow @user
    @active_relationship = current_user.active_relationships
      .find_by followed_id: @user.id
    respond
  end

  def destroy
    relationship = Relationship.find_by id: params[:id]
    return notification unless relationship
    @user = relationship.followed
    current_user.unfollow @user
    @active_relationship = current_user.active_relationships.build
    respond
  end

  private
  def notification
    flash[:alert] = t "relationship_fails"
  end

  def respond
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
