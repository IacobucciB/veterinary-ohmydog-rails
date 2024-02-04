class PerrosController < ApplicationController
  layout 'veterinarios', only: [:new, :index, :personaperro, :create, :ver_info_perro, :historia_clinica, :libreta_sanitaria]
  # before_action :authorize_client, only: [:show_mydata]
  #layout 'clientes'

    def personaperro
      @persona = Persona.find(params[:persona_id])
      @perros = @persona.perros
    end

    def ver_info_perro
      @perro = Perro.find(params[:id])
      render 'ver_info_perro'
    end

    def historia_clinica
      @perro = Perro.find(params[:id])
      @turnos = Turno.where(perro: @perro, estado: Turno.estados[:presente])
      render 'historia_clinica'
    end

    def libreta_sanitaria
      @perro = Perro.find(params[:id])
      @turnos_all = Turno.where(perro: @perro, estado: Turno.estados[:presente])
      @turnos = @turnos_all.where(tipo_turno_id: [1, 2, 4])
      render 'libreta_sanitaria'
    end

    def index
      @perros = Perro.all
      # @perros = Perro.joins(persona: :user).where(users: { is_active: true })
    end

    def new
      @perro = Perro.new
      @persona = Persona.find(params[:persona_id])
      @perro.persona_id = @persona.id
    end

    def create
      @perro = Perro.new(perro_params)
      puts @perro.inspect
      puts @perro.persona_id
      nombre_perro = @perro.nombre
      if @perro.save
        redirect_to "/homeVeterinario", notice: "¡'#{nombre_perro}' registrado correctamente!"
      else
        render 'new'
      end
    end

    private

    def perro_params
      params.require(:perro).permit(:nombre, :edad, :color, :descripcion, :antecedentes, :foto, :persona_id, :sexo, :tipo_raza_id)
    end
end

    #  def create
    #    @perro = Perro.new(perro_params)
    #    puts @perro.persona_id
    #    #@perro = @persona.perros.new(perro_params)
    #    puts "HOLA"
    #    puts @perro.inspect
    #      if @perro.save
    #        redirect_to "/homeVeterinario", notice: "Perro created successfully"
    #      else
    #        render 'new'
    #        puts "NO FUNCIONO"
    #      end
    #    end
