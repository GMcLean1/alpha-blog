module SignInHelper

  def sign_in_as(user,password)
    #puts "Signing in as \"#{user.username}\""
    #post login_path, params[:session][:username] = user.username, params[:session][:password] = password
    post login_path, params:{ session:{username: user.username, password: password }}
  end

end

class ActionDispatch::IntegrationTest
  include SignInHelper
end