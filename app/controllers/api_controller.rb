class ApiController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken
    # protect_from_forgery unless: -> { request.format.json? } 
    #devise_token_authをinstallするとApplicatoinController::Baseに追加された（最初はAPIモードではない）
    # skip_before_action :verify_authenticity_token
end
