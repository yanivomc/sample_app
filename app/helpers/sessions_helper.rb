module SessionsHelper


  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token # Store the user.remember_token from the USER DB in a perment cockie for retirval in difrrent pages 
    
    
    # While the the below call the def current_user=(user) by passing an arggument to it,
    # the def current_user=(user) is setting the variable @current_user to the user it got from the the below call, while the third Def
    # defines what is the @current_user BY saying it = to the @current_user if it's not NIL OR pulling it from the DB if it was NIL
        
    self.current_user = user # This assignment calls the current_user definion below
    
      
    end 
    
    def current_user=(user) # define 
    @current_user = user # define @current_user
  end


  def current_user # locate
    @current_user = @current_user ||= User.find_by_remember_token(cookies[:remember_token]) # match to @current_user if it's not NIL (was already found by this DEF) OR we go to the DB and find @current_user in the DB and save it as that @ variable
  end
  
  def current_user?(user)
    user == current_user
  end
  
# Duplication of the sign_in above
  #def sign_in(user)
   #     cookies.permanent[:remember_token] = user.remember_token
    #    self.current_user = user
     #  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
    def tokenis
        @tokenis = User.find_by_remember_token(cookies[:remember_token])
    end



def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
 end
 
  
end
