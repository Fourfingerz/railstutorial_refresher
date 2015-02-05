require 'test_helper'

class UsersControllerTest < ActionController::TestCase
 
 	def setup
 		@user = users(:michael)
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
end
