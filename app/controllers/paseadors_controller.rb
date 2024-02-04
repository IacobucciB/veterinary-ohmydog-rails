class PaseadorsController < ApplicationController

    before_action :authenticate_user!, except: [:index_paseador_guest]  #Esto me muestra el cartel que luego hay que poner lindo
    before_action :authorize_admin, only: [:new, :create, :index_paseador_veterinario, :edit, :update]
    before_action :authorize_client, only: [:index_paseador_usuario]
    layout 'veterinarios', only: [:new, :create, :index_paseador_veterinario, :edit, :update]
    layout 'veterinarios', except: [:index_paseador_usuario]


    def authorize_admin
        unless current_user && current_user.role == "admin"
        redirect_to root_path, alert: "No tenés permiso para acceder a esta página."
        end
    end

    def authorize_client
        unless current_user && current_user.role == "cliente"
        redirect_to root_path, alert: "No tenés permiso para acceder a esta página."
        end
    end

    def newPaseador
        @paseador = Paseador.new
        render(:layout => "layouts/veterinarios")
    end

    def createPaseador
        @paseador = Paseador.new(paseador_params)
        if @paseador.save
            redirect_to index_paseador_veterinario_path, notice: 'Paseador creado con éxito.'
        else
            render 'newPaseador', alert: 'Ocurrió un error, inténtelo nuevamente.'
        end
    end

    def newCuidador
        @paseador = Paseador.new
        render(:layout => "layouts/veterinarios")
    end

    def createCuidador
        @paseador = Paseador.new(paseador_params)
        if @paseador.save
            redirect_to index_paseador_veterinario_path, notice: 'Cuidador creado con éxito.'
        else
            render 'newCuidador', alert: 'Ocurrió un error, inténtelo nuevamente.'
        end
    end

    def index_paseador_guest
        @paseadors = Paseador.all
        if params[:filter].present?
            @paseadors = @paseadors.where(service_type: params[:filter])
        end
        if params[:plaza_filter].present?
            @paseadors = @paseadors.where(plaza_id: params[:plaza_filter])
        end
        render(:layout => "layouts/base")

    end

    def index_paseador_usuario
        @paseadors = Paseador.all
        if params[:filter].present?
            @paseadors = @paseadors.where(service_type: params[:filter])
        end
        if params[:plaza_filter].present?
            @paseadors = @paseadors.where(plaza_id: params[:plaza_filter])
        end
        render(:layout => "layouts/clientes")
    end

    def index_paseador_veterinario
        @paseadors = Paseador.all
        if params[:filter].present?
            @paseadors = @paseadors.where(service_type: params[:filter])
        end
        if params[:plaza_filter].present?
            @paseadors = @paseadors.where(plaza_id: params[:plaza_filter])
        end
       render(:layout => "layouts/veterinarios")
    end

    def edit
        @paseador = Paseador.find(params[:id])
      end

      def update
        @paseador = Paseador.find(params[:id])
        if @paseador.update(paseador_params)
          redirect_to index_paseador_veterinario_path, notice: 'Paseador actualizado con éxito.'
        else
          render 'edit', alert: 'Ocurrió un error al actualizar, inténtelo nuevamente.'
        end
      end

    private

    def paseador_params
        params.require(:paseador).permit(:name, :service_type, :email, :location, :plaza_id)
    end
end
