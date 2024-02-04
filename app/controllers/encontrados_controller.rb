class EncontradosController < ApplicationController

  before_action :authenticate_user!, except: [:index_encontrado_visitante]  #Esto me muestra el cartel que luego hay que poner lindo
  before_action :authorize_client, only: [:new, :create, :index_encontrado_usuario, :mis_publicaciones_encontrados]
  #before_action :authorize_client, only: [:new, :create]
  layout 'clientes', only: [:new, :create, :index_encontrado_usuario, :mis_publicaciones_encontrados]

  def authorize_client
    unless current_user && current_user.role == "cliente"
      redirect_to root_path, alert: "No tenés permiso para acceder a esta página."
    end
  end

  def new
    @encontrado = Encontrado.new
  end

  def create
    @encontrado = Encontrado.new(encontrado_params)
    @encontrado.estado = 0
    if @encontrado.save
      redirect_to root_path, notice: 'Perro encontrado publicado correctamente.'
    else
      render :new
    end
  end

  def marcar_recuperado
    @publicacion = Encontrado.find(params[:id])
    if @publicacion.update_columns(estado: 'Hallado')
      redirect_to root_path, notice: 'El perro fue marcado como reencontrado!'
    else
      redirect_to root_path, alert: 'Error al marcar como reencontrado el perro.'
    end
  end

  def index_encontrado_usuario
    @encontrados = Encontrado.order(:estado)
    render(:layout => "layouts/clientes")
  end

  def index_encontrado_visitante
    @encontrados = Encontrado.order(:estado)
    render(:layout => "layouts/base")
  end

  def mis_publicaciones_encontrados
    @publicaciones = current_user.encontrados
    render(:layout => "layouts/clientes")
  end

  private

  def encontrado_params
    params.require(:encontrado).permit(:lugar, :dia, :descripcion, :color, :tamanio, :user_id)
  end
end
