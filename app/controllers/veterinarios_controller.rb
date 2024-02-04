class VeterinariosController < ApplicationController
    layout 'veterinarios'

    def homeVeterinario
    end
    
    def registrarCliente 
        @usuario = User.new
        @persona = Persona.new
    end

    def create
        # Verifico si los parámetros "email" y "password" están presentes,lo que indica que se enviaron desde el formulario de Usuario.
        if params[:email] && params[:password]
          # Creo un nuevo objeto Usuario con los datos de email y contraseña.
          @usuario = User.new(email: params[:email], password: params[:password], role: 0)
          # Guardo el nuevo Usuario en la base de datos.
          if @usuario.save
            #Aociación y redireccion a la página de inicio con un mensaje de éxito.
            @persona.user = @usuario
            redirect_to root_path, notice: 'Usuario creado con éxito.'
          else
            #Si hay errores en la creación del Usuario, vuelvo a renderizar el formulario "new".
            render 'registrarCliente'
          end
        else
            redirect_to root_path, notice: 'Fail'
        end
      end
    
      def baja_logica_cliente
        @persona = Persona.find(params[:id])
        if @persona.user.update_columns(is_active: false)
          @persona.perros.each do |perro|
            perro.turno.where(estado: ['pendiente', 'aceptado']).update_all(estado: 'cancelado')
          end
          redirect_to personas_path, notice: 'La persona fue dada de baja correctamente.'
        else
          redirect_to personas_path, alert: 'Error al dar de baja a la persona.'
        end
      end

      private 
      def persona_params
        params.require(:persona).permit(:nombre, :apellido, :dni, :telefono, :nacimiento, :donante)
      end
end