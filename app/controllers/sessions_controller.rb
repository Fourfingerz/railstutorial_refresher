class SessionsController < ApplicationController
  #Login Controller (Temporary Sessions)
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  		# Pulls user out of DB by email. Matches downcased emails.
  	if user && user.authenticate(params[:session][:password])
  		# && determines if user is valid
  		# User       | Password      | a && b
  		# noneistent   anything        (nil && [anything]) == false
  		# valid user   wrong password  (true && false) == false
  		# valid user   right password  (true && true) == true

  		#  Then log the user in and redirect to the user's show page
      log_in user # Rails automatically converts this to user_url(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # That line is equivalent to the code below
      # if params[:session][:remember_me] == '1'
      #   remember(user)
      # else
      #   forget(user)
      # end
      redirect_to user
  	else
  		flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
