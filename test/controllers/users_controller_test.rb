require 'test_helper'

class UsersControllerTest < ActionController::TestCase
 
 	def setup
 		@user = users(:michael)
 		@other_user = users(:archer)
 	end

 	test "should redirect index when not logged in" do
 		get :index
 		assert_redirected_to login_url
 	end

 	test "should get new" do 
 		get :new
 		assert_response :success
 	end

 	test "should redirect edit when not logged in" do
 		# Edit is SHOWING page for editing
 		get :edit, id: @user
 		assert_not flash.empty?
 		assert_redirected_to login_url
 	end

 	test "should redirect update when not logged in" do
 		# Patching is actually POSTING updates to SQL
 		patch :update, id: @user, user: { name: @user.name, email: @user.email }
 		assert_not flash.empty?
 		assert_redirected_to login_url
 	end

 	test "should redirect edit when logged in as wrong user" do
 		log_in_as(@other_user)
 		get :edit, id: @user # So any user is sneaky and copy and pasting buddy's edit url into link
 		assert flash.empty? # Checks if the flash tells him to f*ck off
 		assert_redirected_to root_url # GO HOME!
 	end

 	test "should redirect update when logged in as wrong user" do
 		log_in_as(@other_user) # Logged in as Archer
 		patch :update, id: @user, user: { name: @user.name, email: @user.email } # Wait you're posting as Michael?!
 		assert flash.empty? # Checks if flash tells him to f*ck off
 		assert_redirected_to root_url # GET OUTTA TOWN!
 	end
end
