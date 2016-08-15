module Authenticable

  # Devise methods overwrites
  def api_current_user
    @api_current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" }, status: :unauthorized unless api_current_user.present?
  end

  def api_user_signed_in?
    api_current_user.present?
  end
end