class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
    # protect_from_forgery unless: -> { request.format.json? }
    # skip_before_action :verify_authenticity_token, if: :devise_controller? 

    private
    def sign_up_params
        params.permit(:name, :email, :status, :password, :password_confirmation)
    end

    def account_update_params
        params.permit(:name, :email)
    end
end
