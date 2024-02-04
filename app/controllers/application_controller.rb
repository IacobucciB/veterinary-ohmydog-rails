# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
    layout 'base' # Esto especifica el diseño base que se va a usar, donde está definida la imagen de fondo, el navbar, etc

    def after_sign_in_path_for(resource)
      if current_user.admin?
        '/homeVeterinario'
      else 
        '/homeClientes'
      end
    end

    def home
    end

    def determine_root
      if user_signed_in?
        if current_user.role == 'cliente'
          redirect_to homeClientes_path
        else
          redirect_to homeVeterinario_path
        end
      else
        render 'home'
      end
    end

    def under_construction
      render 'under_construction'
    end
    
  end

