class PagesController < ApplicationController
  def index
    @user = current_user
    @team = @user.team
  end
end
