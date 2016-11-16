class AdministratorController < ActionController::Base
	layout "application"
  protect_from_forgery with: :exception
end
