class Api::V1::RegistrationsController < Devise::RegistrationsController
  # before_action(:ensure_params_exist, only: :create)
  before_action :ensure_params_exist, only: :create
  #sign up
  def create
    user = User.new(user_params)
    # p "here is user" + user.to_s
    if user.save
      json_response "Signed up successfully", true, {user: user}, :ok
    else
      json_response "Something is wrong", false, {}, :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
  def ensure_params_exist
    return if params[:user].present?
    json_response "Missing information", false, {}, :bad_request
    #same code above just refactored the below code
    #json_response defined in app/controlers/concerns/response.rb and included in application_controller.rb
    # render json: {
    #   message: "Missing information",
    #   is_success: false,
    #   data: {}
    # }, status: :bad_request
  end
end
