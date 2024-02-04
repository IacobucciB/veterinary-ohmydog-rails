# app/controllers/tarjeta_creditos_controller.rb
class TarjetaCreditosController < ApplicationController
  before_action :authenticate_user!, except: [:donarVisitante, :procesar_dono_visitante]
  before_action :authorize_client, only: [:new, :index, :create, :edit, :update, :destroy, :donar, :informacion_correcta,:procesar_dono]
  layout 'clientes', only: [:new, :index, :create, :edit, :update, :destroy, :donar, :procesar_dono, :informacion_correcta]
  layout 'base', except: [:new, :index, :create, :edit, :update, :destroy, :donar, :procesar_dono, :informacion_correcta]
  # def authorize_admin
  #   unless current_user && current_user.role == "admin"
  #     redirect_to root_path, alert: "No tenés permiso para acceder a esta página."
  #   end
  # end

  def authorize_client
    unless current_user && current_user.role == "cliente"
      redirect_to root_path, alert: "No tenés permiso para acceder a esta página."
    end
  end


  def index
    @tarjeta_creditos = TarjetaCredito.all
  end

  def new
    @tarjeta_credito = TarjetaCredito.new
    render(:layout => "layouts/clientes")
  end

  def create
    @tarjeta_credito = TarjetaCredito.new(tarjeta_credito_params)
    if @tarjeta_credito.save
      redirect_to @tarjeta_credito, notice: 'Tarjeta de crédito creada con éxito.'
    else
      render 'new'
    end
  end

  def edit
    @tarjeta_credito = TarjetaCredito.find(params[:id])
    render(:layout => "layouts/clientes")
  end

  def update
    if @tarjeta_credito.update(tarjeta_credito_params)
      redirect_to @tarjeta_credito, notice: 'Tarjeta de crédito actualizada con éxito.'
    else
      render 'edit'
    end
  end

  def destroy
    @tarjeta_credito.destroy
    redirect_to tarjeta_creditos_path, notice: 'Tarjeta de crédito eliminada con éxito.'
  end


  def informacion_correcta(nombre, numero, fecha_vencimiento, codigo_seguridad)
    @tarjeta_credito_guardada = TarjetaCredito.find_by(nombre: nombre)

    if @tarjeta_credito_guardada.present?
      if @tarjeta_credito_guardada.numero == numero
        if @tarjeta_credito_guardada.fecha_vencimiento.to_s == fecha_vencimiento.to_s
          if @tarjeta_credito_guardada.codigo_seguridad.to_s == codigo_seguridad.to_s
            puts "La información de la tarjeta de crédito es correcta."
            # Puedes realizar otras acciones aquí si la información es correcta
            return true
          end
        end
      end
    end
    # Puedes realizar otras acciones aquí si la información es incorrecta o no se encontró
    return false
  end


  def donar
    render(:layout => "layouts/clientes")
  end

  def donarVisitantes
    render(:layout => "layouts/base")
  end

  def procesar_dono
    campania_id = params[:campania_id]
    @tarjeta_credito = TarjetaCredito.where(
      nombre: params[:nombre]
      ).first
    nombre = params[:nombre]
    numero = params[:numero]
    fecha_vencimiento = params[:fecha_vencimiento]
    codigo_seguridad = params[:codigo_seguridad]
    monto = params[:monto].to_i

    if informacion_correcta(nombre, numero, fecha_vencimiento, codigo_seguridad)
      if monto < @tarjeta_credito.saldo
        @persona = Persona.find(current_user.id)
        @persona.update(donante: true)

        nuevo_saldo = @tarjeta_credito.saldo - monto
        @tarjeta_credito.update(saldo: nuevo_saldo)

        @campania = CampaniaDonacion.find(campania_id)
        puts @campania.inspect
        nuevo_actual = @campania.monto_actual + monto
        @campania.update(monto_actual: nuevo_actual)

        redirect_to ver_campanias_path, notice: 'Donación realizada. ¡Muchas Gracias!'
      else
        redirect_to donar_path(id: campania_id, nombre: params[:nombre], numero: params[:numero], fecha_vencimiento: params[:fecha_vencimiento], codigo_seguridad: params[:codigo_seguridad], monto: params[:monto]), alert: 'Fondos insuficientes'
      end
    else
      redirect_to donar_path(id: campania_id, nombre: params[:nombre], numero: params[:numero], fecha_vencimiento: params[:fecha_vencimiento], codigo_seguridad: params[:codigo_seguridad], monto: params[:monto]), alert: 'Tarjeta inválida.'
    end

  end

  def procesar_dono_visitante
    campania_id = params[:campania_id]
    @tarjeta_credito = TarjetaCredito.where(
      nombre: params[:nombre]
      ).first
    nombre = params[:nombre]
    numero = params[:numero]
    fecha_vencimiento = params[:fecha_vencimiento]
    codigo_seguridad = params[:codigo_seguridad]
    monto = params[:monto].to_i

    if informacion_correcta(nombre, numero, fecha_vencimiento, codigo_seguridad)
      if monto < @tarjeta_credito.saldo
        nuevo_saldo = @tarjeta_credito.saldo - monto
        @tarjeta_credito.update(saldo: nuevo_saldo)

        @campania = CampaniaDonacion.find(campania_id)
        nuevo_actual = @campania.monto_actual + monto
        @campania.update(monto_actual: nuevo_actual)

        redirect_to ver_campanias_publico_path, notice: 'Donación realizada. ¡Muchas Gracias!'
      else
        redirect_to donar_visitante_path(id: campania_id, nombre: params[:nombre], numero: params[:numero], fecha_vencimiento: params[:fecha_vencimiento], codigo_seguridad: params[:codigo_seguridad], monto: params[:monto]), alert: 'Fondos insuficientes'
      end
    else
      redirect_to donar_visitante_path(id: campania_id, nombre: params[:nombre], numero: params[:numero], fecha_vencimiento: params[:fecha_vencimiento], codigo_seguridad: params[:codigo_seguridad], monto: params[:monto]), alert: 'Tarjeta inválida.'
    end

  end



  private

  def set_tarjeta_credito
    @tarjeta_credito = TarjetaCredito.find(params[:id])
  end

  def tarjeta_credito_params
    params.require(:tarjeta_credito).permit(:numero, :nombre, :fecha_vencimiento, :codigo_seguridad, :saldo)
  end

  def campania_donacion_params
    params.require(:campania).permit(:nombre, :descripcion, :fecha_final, :monto_actual, :monto_objetivo)
  end
end
