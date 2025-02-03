class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  rescue_from StandardError, with: :handle_error

  helper_method :current_user

  def handle_error(e)
    flash["error"] = "Unauthorized"
    redirect_to :root

    # code to send email and redirect to error page
  end

  def current_user
    User.find_by_id(cookies[:user_id]) || User.first
  end
end
