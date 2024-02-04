class TurnosController < ApplicationController
  layout 'clientes', except: [:newUrgencia, :createUrgencia, :turnos_del_dia, :aceptar, :rechazar, :mostrarTodos, :show_turno_historiaClinica, :show_turno_libretaSanitaria, :historial_gastos]
  layout 'veterinarios', only: [:newUrgencia, :createUrgencia, :turnos_del_dia, :aceptar, :rechazar, :mostrarTodos, :show_turno_historiaClinica, :show_turno_libretaSanitaria, :historial_gastos]

  before_action :authenticate_user! #Esto me muestra el cartel que luego hay que poner lindo
  before_action :authorize_admin, only: [:index, :newUrgencia, :turnos_del_dia, :historial_gastos]
  before_action :authorize_client, only: [:new]

  def authorize_admin
    unless current_user && current_user.role == "admin"
      redirect_to root_path, alert: "No tenés permiso para acceder a esta página."
    end
  end

  def authorize_client
    unless current_user && current_user.role == "cliente"
      redirect_to root_path, alert: "No tienes permiso para acceder a esta página."
    end
  end

  def index
    @turnos = Turno.where(estado: 'pendiente')
    render(:layout => "layouts/veterinarios")
  end

  def mostrarTodos
    @turnos = Turno.all.order(:estado, :dia)
    if params[:filter].present?
      @turnos = @turnos.where(estado: params[:filter])
    end
    render(:layout => "layouts/veterinarios")
  end

  def new
    @turno = Turno.new
    render(:layout => "layouts/clientes")
  end

  def create
    @turno = Turno.new(turno_params)
    @turno.estado ||= "pendiente"

    if @turno.save
      UserMailer.turno_pend(User.new(email: @turno.perro_id), @turno.tipo_turno_id, @turno.perro_id, @turno.dia).deliver
      redirect_to homeClientes_path, notice: 'Turno solicitado correctamente.'
    else
      render :new, layout: "layouts/clientes"
    end
  end

  def get_perros_by_persona
    persona_id = params[:persona_id]
    persona = Persona.find(persona_id)
    perros = persona.perros

    render json: perros
  end

  def newUrgencia
    @turno = Turno.new
    @users_activos = User.where(is_active: true, role: 0)
    @personas = @users_activos.map(&:persona)
    # render(:layout => "layouts/veterinarios")
  end

  def createUrgencia
    @turno = Turno.new(turno_params)
    @turno.estado ||= "presente"
    @turno.tipo_turno_id = TipoTurno.find_by(nombre: 'Urgencia').id
    if @turno.save
      # UserMailer.turno_pend(User.new(email: @turno.perro_id), @turno.tipo_turno_id, @turno.perro_id, @turno.dia).deliver
      # redirect_to root_path, notice: 'Turno de Urgencia creado.'
      render :presente_default, layout: "layouts/veterinarios"
    else
      render :newUrgencia, layout: "layouts/veterinarios"
      # puts "Errors: #{@turno.errors.full_messages}"
    end
  end

  def turnos_del_dia
    @turnos = Turno.where(dia: Date.today, estado: 1)
    render 'turnos_del_dia', layout: "layouts/veterinarios"
  end

  def aceptar
    @turno = Turno.find(params[:id])
  end

  def procesar_aceptar
    @turno = Turno.find(params[:id])
    hora_cita = "#{params['hora_cita(4i)']}:#{params['hora_cita(5i)']}"
    puts "Hora(4i) convertida a entero: #{params['hora_cita(4i)'].to_i}"
    if @turno.franja_horaria == 'pm' && (params['hora_cita(4i)'].to_i > 21 || params['hora_cita(4i)'].to_i < 15 )
      flash.now[:alert] = 'El cliente seleccionó franja horaria PM (entre las 15:00 y las 22:00), seleccione una hora válida o rechace el turno.'
      render :aceptar, layout: "layouts/veterinarios"
      return
    elsif @turno.franja_horaria == 'am' && (params['hora_cita(4i)'].to_i < 8 || params['hora_cita(4i)'].to_i > 11)
      flash.now[:alert] = 'El cliente seleccionó franja horaria AM (entre las 08:00 y las 12:00), seleccione una hora válida o rechace el turno.'
      render :aceptar, layout: "layouts/veterinarios"
      return
    end
    @turno.update(estado: 'aceptado')
    # @turno.update(hora: params[:hora_cita])
    hora = "#{params['hora_cita(4i)'].to_i}:#{params['hora_cita(5i)'].to_i}"
    @turno.update(hora: Time.parse(hora))
    anotacion = params[:anotacion]
    hora_cita = "#{params['hora_cita(4i)']}:#{params['hora_cita(5i)']}"
    UserMailer.turno_aceptado(User.new(email: @turno.perro.persona.user.email), @turno.tipo_turno_id, @turno.perro_id, @turno.dia, @turno.franja_horaria, anotacion, hora_cita).deliver

    redirect_to "/turnos", notice: 'Turno aceptado y correo electrónico enviado.'
  end

  def rechazar
    @turno = Turno.find(params[:id])
  end

  def procesar_rechazar
    @turno = Turno.find(params[:id])
    @turno.update(estado: 'rechazado')
    anotacion = params[:anotacion]
    UserMailer.turno_rechazado(User.new(email: @turno.perro.persona.user.email), @turno.tipo_turno_id, @turno.perro_id, @turno.dia, @turno.franja_horaria, anotacion).deliver

    redirect_to "/turnos", notice: 'Turno rechazado y correo electrónico enviado.'
  end

  def ausente
    @turno = Turno.find(params[:id])
    @turno.update(estado: :ausente)
    redirect_to "/turnos_del_dia", notice: 'Turno marcado como ausente'
  end


  def presente
    @turno = Turno.find(params[:id])
    @turno.update(estado: :presente)
    @tipo_turno = @turno.tipo_turno

    case @tipo_turno.nombre
    when 'Desparasitacion'
      render 'presente_desparasitacion', layout: 'veterinarios'
    when 'Vacuna tipo A'
      render 'presente_vacunacion', layout: 'veterinarios'
    when 'Vacuna tipo B'
      render 'presente_vacunacion', layout: 'veterinarios'
    else
      render 'presente_default', layout: 'veterinarios'
    end
  end

  def show_turno_historiaClinica
    @turno = Turno.find(params[:id])
    render(:layout => "layouts/veterinarios")
  end

  def show_turno_libretaSanitaria
    @turno = Turno.find(params[:id])
    render(:layout => "layouts/veterinarios")
  end

  def update
    @turno = Turno.find(params[:id])

    @perro = Perro.find(@turno.perro_id)
    if @turno.tipo_turno.nombre == 'Vacuna tipo A' && @perro.edad >= 2 && @perro.edad < 4
      fecha_turno_especial = Date.today + 21.days
      UserMailer.turno_vacunaa(User.new(email: @turno.perro_id), @turno.tipo_turno_id, @turno.perro_id, fecha_turno_especial).deliver
      @turno_nuevo = Turno.create
      @turno_nuevo.dia = fecha_turno_especial
      @turno_nuevo.franja_horaria = @turno.franja_horaria
      @turno_nuevo.estado = 1
      @turno_nuevo.perro_id = @turno.perro_id
      @turno_nuevo.tipo_turno_id = 1
      @turno_nuevo.save
    elsif (@turno.tipo_turno.nombre == 'Vacuna tipo A' && @perro.edad >= 4) || (@turno.tipo_turno.nombre == 'Vacuna tipo B' && @perro.edad >= 4)
      fecha_turno_especial = Date.today + 365.days
      hora_turno_especial = @turno.hora
      franja_horaria= @turno.franja_horaria
      UserMailer.turno_vacuna_anual(User.new(email: @turno.perro_id), @turno.tipo_turno_id, @turno.perro_id, fecha_turno_especial, hora_turno_especial,franja_horaria).deliver
      @turno_nuevo = Turno.create
      @turno_nuevo.dia = fecha_turno_especial
      @turno_nuevo.franja_horaria = @turno.franja_horaria
      @turno_nuevo.hora = @turno.hora
      @turno_nuevo.estado = 1
      @turno_nuevo.perro_id = @turno.perro_id
      @turno_nuevo.tipo_turno_id = @turno.tipo_turno_id
      @turno_nuevo.save
    end

    if @turno.update(turno_params)
      if @turno.perro.persona.donante
      @turno.update(monto: @turno.monto * 0.8)
      @turno.perro.persona.update(donante: false)
    end
      # Handle successful update
      if @turno.tipo_turno.nombre == "Desparasitacion"
        redirect_to show_turno_libreta_path(@turno), notice: 'Libreta Sanitaria actualizada.'
      else
        redirect_to show_turno_historia_path(@turno), notice: 'Historia Clínica actualizada.'
      end
    else
      # Handle validation errors or other issues
      render :edit
    end

  end


  def historial_gastos
    @cliente = User.find(params[:user_id])
    @turnos = Turno.where(perro_id: @cliente.persona.perros.pluck(:id)).where(estado: [:presente])
  end

  private
  def turno_params
    params.require(:turno).permit(:dia, :franja_horaria, :estado, :monto, :perro_id, :tipo_turno_id, :dosis, :descripcion, :peso)
  end

end
