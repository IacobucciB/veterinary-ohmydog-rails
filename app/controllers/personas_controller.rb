class PersonasController < ApplicationController
  before_action :authenticate_user!  #Esto me muestra el cartel que luego hay que poner lindo
  before_action :authorize_admin, only: [:new_user_and_persona, :create_user_and_persona, :index, :datos_personales]
  before_action :authorize_client, only: [:show_mydata, :baja_logica_perro]
  layout 'veterinarios', except: [:editar, :update, :baja_logica_perro]
  layout 'clientes', only: [:editar, :update, :baja_logica_perro]

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

  def homeCliente
    render(:layout => "layouts/clientes")
  end

  def new_user_and_persona
      # Aquí se muestra el formulario para crear usuario y persona
      @persona = Persona.new
      render(:layout => "layouts/veterinarios")
  end

  def generate_random_password
    lowercase_letters = ('a'..'z').to_a
    uppercase_letters = ('A'..'Z').to_a
    numbers = ('0'..'9').to_a
    symbols = ['!', '@', '#', '$', '%', '^', '&', '*']
    # Ensure at least one character from each category
    password = [
      lowercase_letters.sample,
      uppercase_letters.sample,
      numbers.sample,
      symbols.sample
    ]
    # Fill the remaining characters with random selections
    remaining_length = 8 - password.length
    all_characters = lowercase_letters + uppercase_letters + numbers + symbols
    password += all_characters.sample(remaining_length)
    # Shuffle the password to make the order random
    password.shuffle.join
  end

  def create_user_and_persona
    random_password = generate_random_password
    @usuario = User.new(email: params[:email], password: random_password, role: 0)
    @persona = Persona.new(nombre: params[:nombre], apellido: params[:apellido], dni: params[:dni], telefono: params[:telefono], nacimiento: params[:nacimiento], donante: false)

    ActiveRecord::Base.transaction do
      # unless @usuario.save
      #   raise ActiveRecord::RecordInvalid.new(@usuario)
      # end
      # @persona.user = @usuario
      # unless @persona.save
      #    raise ActiveRecord::RecordInvalid.new(@persona)
      # end
      unless @usuario.valid? || @persona.valid?
         @persona.errors.merge!(@usuario) #= @persona.errors + @usuario.errors
         #@errors = ActiveModel::Errors.new(@persona)
         #puts @errors.inspect
         raise ActiveRecord::RecordInvalid.new(@persona)
         puts errors_messages
       end
      # unless @persona.save && @usuario.save
      #   errors_messages = @persona.errors.full_messages + @usuario.errors.full_messages
      #   #raise ActiveRecord::RecordInvalid.new(errors_messages)
      # end
      @usuario.save
      @persona.user = @usuario
      @persona.save

      UserMailer.example(User.new(email: @usuario.email), random_password).deliver
      redirect_to new_persona_perro_path(persona_id: @persona.id), notice: 'Usuario registrado con éxito.'

      rescue ActiveRecord::RecordInvalid => e
        puts "ERROR saving records: #{e.message}"
        render 'new_user_and_persona', layout: 'veterinarios'
      end
  end

  def index
    @personas = if params[:nombre_apellido].present?
      # Persona.where("nombre LIKE ? OR apellido LIKE ?", "%#{params[:nombre_apellido]}%", "%#{params[:nombre_apellido]}%")
      palabras = params[:nombre_apellido].split
      condiciones = palabras.map do |palabra|
        "(LOWER(nombre) LIKE :keyword OR LOWER(apellido) LIKE :keyword)"
      end
      condiciones_sql = condiciones.join(" AND ")
      condiciones_hash = palabras.map { |palabra| { keyword: "%#{palabra.downcase}%" } }
      Persona.joins(:user).where(condiciones_sql, *condiciones_hash).where(users: { role: 'cliente', is_active: true })
    else
      @personas = Persona.joins(:user).where.not(users: { role: 'admin' })
      # @personas = Persona.joins(:user).where(users: { role: 'cliente', is_active: true })
    end
    render(:layout => "layouts/veterinarios")
  end

  def show_mydata
    @persona = current_user.persona 
    # @perros = @persona.perros
    @perros = @persona.perros.where(is_active: true)
    render(:layout => "layouts/clientes")
  end

  def baja_logica_perro
    @perro = Perro.find(params[:id])
    if @perro.update_columns(is_active: false)
      @perro.turno.where(estado: ['pendiente', 'aceptado']).update_all(estado: 'cancelado')
      redirect_to show_my_data_path(id: @perro.persona_id), notice: 'El perro fue dado de baja correctamente y sus turnos fueron cancelados.'
    else
      redirect_to personas_path, alert: 'Error al dar de baja al perro.'
    end
  end

  def editar
    @persona = Persona.find(params[:id])
    render(:layout => "layouts/clientes")
  end

  def update
    @persona = Persona.find(params[:id])
    if @persona.update(persona_params)
      redirect_to homeClientes_path, notice: 'Perfil actualizado exitosamente.'
    else
      puts @persona.errors.full_messages.inspect
      render :editar
    end
  end

  def datos_personales
    @persona = Persona.find(params[:id])
    render(:layout => "layouts/veterinarios")
  end

    private

    def persona_params
      params.require(:persona).permit(:nombre, :apellido, :dni, :telefono, :nacimiento, :donante, :user_id, :id)
    end

  end
