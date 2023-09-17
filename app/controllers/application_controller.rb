class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :profile_image])
  end

    private
  
    def generate_sns_url(type, username)
      base_url = case type
                 when 'Twitter' then "https://twitter.com/"
                 when 'Facebook' then "https://facebook.com/"
                 when 'Instagram' then "https://instagram.com/"
                 # 他のSNSのURLを必要に応じて追加
                 else
                   return nil
                 end
      base_url + username
    end
  end
  

