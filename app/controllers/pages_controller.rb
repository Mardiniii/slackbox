class PagesController < WebController
  def index
    if user_signed_in?
      @user = current_user
      @team = @user.team
    end
  end
end
