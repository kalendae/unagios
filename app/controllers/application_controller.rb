# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  @@password = nil
  before_filter :check_logged_in, :except => [:login]

  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to]=nil
      redirect_to(return_to)
    else
      redirect_to root_path
    end
  end


  def check_logged_in
    @@password = YAML.load_file("#{RAILS_ROOT}/config/password.yml") if @@password.nil?
    if session[:expiry] and session[:expiry] < Time.now
        reset_session
    end
    if session[:pw] != @@password
      session[:return_to]=request.request_uri
      redirect_to login_path
      return false
    end
    return true
  end

  
end
