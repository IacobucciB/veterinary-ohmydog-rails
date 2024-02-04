class PerdidoEncontradosController < ApplicationController

  before_action :authenticate_user!, except: [:perdido_encontrado_visitante, :new, :create, :show_reencuentros]  #Esto me muestra el cartel que luego hay que poner lindo
  #before_action :authorize_admin, only: [:new, :create, :editar, :update, :vistaVeterinario]
  before_action :authorize_client, only: [:perdido_encontrado_usuario, :new, :create, :mis_publicaciones_perdidos, :marcar_encontrado]
  layout 'clientes', only: [:new, :create, :perdido_encontrado_usuario, :mis_publicaciones_perdidos]

  def authorize_client
    unless current_user && current_user.role == "cliente"
      redirect_to root_path, alert: "No tenés permiso para acceder a esta página."
    end
  end

  def perdido_encontrado_usuario
    @perdido_encontrados = PerdidoEncontrado.where(estado: 'Busqueda')
    render(:layout => "layouts/clientes")
  end

  def perdido_encontrado_visitante
    # @perdido_encontrados = PerdidoEncontrado.all
    @perdido_encontrados = PerdidoEncontrado.where(estado: 'Busqueda')
    render(:layout => "layouts/base")
  end

  def mis_publicaciones_perdidos
    persona_id = current_user.persona.id
    perros_ids = Perro.where(persona_id: persona_id).pluck(:id)
    @publicaciones = PerdidoEncontrado.where(perro_id: perros_ids).order(:estado)
    render(:layout => "layouts/clientes")
  end

  def new
    @perdido_encontrado = PerdidoEncontrado.new
  end

  def create
    @perdido_encontrado = PerdidoEncontrado.new(perdido_encontrado_params)

    if @perdido_encontrado.save
      @perdido_encontrado.perro.update_columns(is_lost: true)
      @perdido_encontrado.perro.turno.where(estado: ['pendiente', 'aceptado']).update_all(estado: 'cancelado')
      redirect_to perdido_encontrado_usuario_path, notice: 'Perro publicado como perdido correctamente. No te olvides de marcarlo como encontrado si llega a pasar!'
    else
      render :new
    end
  end

  def marcar_encontrado
    @publicacion = PerdidoEncontrado.find(params[:id])
    if @publicacion.perro.update_columns(is_lost: false)
      @publicacion.update_columns(estado: 'Hallado')
      redirect_to perdido_encontrado_usuario_path, notice: 'El perro fue dado de alta nuevamente'
    else
      redirect_to perdido_encontrado_usuario_path, alert: 'Error al dar de baja al perro.'
    end
  end

  def show_reencuentros
    @reencuentros = PerdidoEncontrado.where(estado: 'Hallado')
    if current_user
      render(:layout => "layouts/clientes")
    else
      render(:layout => "layouts/base")
    end
  end

  private

  def set_perdido_encontrado
    @perdido_encontrado = PerdidoEncontrado.find(params[:id])
  end

  def perdido_encontrado_params
    params.require(:perdido_encontrado).permit(:zona, :dia, :observacion, :estado, :tipo, :perro_id)
  end

end
