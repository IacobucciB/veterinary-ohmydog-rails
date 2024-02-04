class CampaniaDonacionsController < ApplicationController

  before_action :authenticate_user!, except: [:vistaPublica]  #Esto me muestra el cartel que luego hay que poner lindo
  before_action :authorize_admin, only: [:new, :create, :editar, :update, :vistaVeterinario]
  before_action :authorize_client, only: [:vistaUsuario]
  layout 'veterinarios', only: [:new, :create, :editar, :update, :vistaVeterinario]
  layout 'veterinarios', except: [:vistaUsuario]
  #layout 'clientes', only: [:vistaUsuario]

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

  def vistaUsuario
    @campanias = CampaniaDonacion.all
    render(:layout => "layouts/clientes")
  end

  def vistaVeterinario
    @campanias = CampaniaDonacion.all
    render(:layout => "layouts/veterinarios")
  end

  def vistaPublica
   @campanias = CampaniaDonacion.all
   render(:layout => "layouts/base")
  end


   def new
     @campania = CampaniaDonacion.new
     render(:layout => "layouts/veterinarios")
   end

   def create
     @campania = CampaniaDonacion.new(campania_donacion_params)
     if @campania.save
       redirect_to vista_veterinario_path, notice: 'Campaña de donación creada con éxito.'
     else
      #redirect_to nueva_campania_path #, notice: 'Campaña no se pudo crear.'
      render 'new'
     end
   end

  def editar
    @campania = CampaniaDonacion.find(params[:id])
    render(:layout => "layouts/veterinarios")
  end

  def update
    @campania = CampaniaDonacion.find(params[:id])
    if @campania.update(campania_donacion_params)
      redirect_to vista_veterinario_path, notice: 'Perfil actualizado exitosamente.'
    else
      puts @campania.errors.full_messages.inspect
      render :editar
    end
  end



  private

  def campania_donacion_params
    params.require(:campania_donacion).permit(:nombre, :descripcion, :fecha_final, :monto_actual, :monto_objetivo)
  end

end
