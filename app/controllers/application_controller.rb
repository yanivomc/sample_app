class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  #By including the seesionHelper module in the Application Controller, we're makeing sure the sessionHelper will be exposed to the all MVC
  #By default, all the helpers are available in the views but not in the controllers. 
  #We need the methods from the Sessions helper in both places, so we have to include it explicitly.
  
  
  # Force signout to prevent CSRF  cross-site request forgery safeguard attacks
  def handle_unverified_request
    sign_out
    super
end
end
