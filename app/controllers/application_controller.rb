class ApplicationController < ActionController::Base
#devise利用の機能（ユーザ登録、ログイン認証など）が使われる前に、configure_permitted_parametersメソッドが実行されます。
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:top, :about]

    def after_sign_in_path_for(resource)
      user_path(current_user)
    end

    def after_sign_out_path_for(resource)
      root_path
    end

  protected

#ユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可する記述。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
