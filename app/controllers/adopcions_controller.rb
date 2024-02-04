class AdopcionsController < ApplicationController
    # before_action :set_adopcion, only: [:show, :edit, :update, :destroy]
    layout 'clientes'

    def index
      # @adopciones = Adopcion.all
      @adopciones = Adopcion.order(:estado)
      if current_user
        render(:layout => "layouts/clientes")
      else
        render(:layout => "layouts/base")
      end
    end

    def show
    end

    def new
      @adopcion = Adopcion.new
    end

    # def new_mi_perro
    #   @perros = Perro.where(persona_id: params[:id])
    # end
    
    #   def create_mi_perro
    #     perro_id = params[:perro_id]
    #     @perro = Perro.find(perro_id)

    #     adopcion = Adopcion.new(
    #       # tamanio: @perro,
    #       otro_parametro: valor,
    #       # ... otros parámetros ...
    #     )
    #     @adopcion.estado ||= "Publicado"
    #     if @adopcion.save
    #       redirect_to "/adopciones", notice: 'Perro publicado correctamente en adopción.'
    #     else
    #       render :new
    #     end
    #   end

    def create
      @adopcion = Adopcion.new(adopcion_params)
      @adopcion.estado ||= "Publicado"
      if @adopcion.save
        redirect_to "/adopciones", notice: 'Perro publicado correctamente en adopción.'
      else
        render :new
      end
    end

    def adopcionesVisitante
      @adopciones = Adopcion.all
      render(:layout => "layouts/base")
    end

    def mis_publicaciones
      @publicaciones = Adopcion.where(persona_id: current_user.persona.id)
      render(:layout => "layouts/clientes")
    end

    def adoptar
      @publicacion = Adopcion.find(params[:id])
      render(:layout => "layouts/base")
    end

    def adoptar_datos
      @publicacion_id = params[:id]
      @adopcion = Adopcion.find(@publicacion_id)
      if  params[:email].blank? ||  params[:telefono].blank? ||  params[:nombre].blank? || params[:apellido].blank?
        flash[:alert] = 'Por favor complete todos los campos.'
        puts "parametro:  #{params[:email]}"
        flash[:input_params] = {
          email: params[:email],
          telefono: params[:telefono],
          nombre: params[:nombre],
          apellido: params[:apellido],
          razon: params[:razon]
        }
        puts "parametro:  #{flash[:input_params][:email]}"

        redirect_back(fallback_location: root_path(id: @publicacion_id))
      else
        @duenio= Persona.find(@adopcion.persona_id)
        @usuarioDuenio=User.find(@duenio.user_id)
        UserMailer.adopcion_contactar(User.new(email: @usuarioDuenio.email), @duenio.nombre, @duenio.apellido,
        params[:nombre], params[:apellido], params[:telefono], params[:email], params[:razon], @adopcion).deliver
        flash[:notice] = 'Email Enviado. A la brevedad serás contactado por el dueño de la publicación.'
        redirect_to "/adopciones"
      end
    end

    def marcar_adoptado
      @publicacion = Adopcion.find(params[:id])
      if @publicacion.update_columns(estado: "Adoptado")
        redirect_to adopciones_index_path, notice: '¡El perro fue marcado como adoptado!.'
      else
        redirect_to adopciones_index_path, alert: 'Error al marcar como adoptado el perro.'
      end
    end

    private

    def set_adopcion
      @adopcion = Adopcion.find(params[:id])
    end

    def adopcion_params
      params.require(:adopcion).permit(:tipo_raza_id, :sexo, :tamanio, :origen, :estado, :persona_id)
    end

end
