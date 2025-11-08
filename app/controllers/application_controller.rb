class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Chama o método de configuração antes do devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Método para adicionar 'name' aos strong parameters do Devise
  def configure_permitted_parameters
    # Permite 'name' no cadastro (sign up)
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])

    # Permite 'name' na edição de conta (account update)
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
