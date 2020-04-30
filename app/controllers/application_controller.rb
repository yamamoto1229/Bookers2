class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :configure_permitted_redirect, only: [:new],if: :devise_controller?
	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
	end
	def after_sign_in_path_for(resource)
		user_path(resource.id)
	end
	def configure_permitted_redirect
		if user_signed_in?
			redirect_to user_path(current_user)
		end
	end
end
