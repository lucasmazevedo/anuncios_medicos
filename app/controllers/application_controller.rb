class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

	protected

	def layout_by_resource
	  if devise_controller? && resource_name == :admin
	    "application"
	  else
	    "site"
	  end
	end

  def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up) do |user_params|
	 		user_params.permit({  profile_attributes: [:id, :fullname, :cpf, :phonearea, :phone, :birthdate, :zipcode, :street, :number, :district, :city, :state, :avatar, :_destroy], }, :email, :password, :password_confirmation)
	  end
	end

end
