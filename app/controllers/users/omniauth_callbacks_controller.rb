class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def slack
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    User.associate_or_create_team(request.env["omniauth.auth"], @user) if @user.team.nil?
    @user.team.update(name: request.env["omniauth.auth"].info.team) if @user.team.name.nil?
    @user.update(provider: 'slack', email: request.env["omniauth.auth"].info.email,
    image: request.env["omniauth.auth"].info.image) if @user.email.empty?

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Slack") if is_navigational_format?
    else
      session["devise.slack_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

end
