class ClientesController < ApplicationController
    layout 'clientes'
    before_action :authenticate_user!
    before_action :set_persona, only: [:show]

    def show
        @perros = @persona.perros
    end

    private

    def set_persona
        @persona = current_user.persona
    end

    def homeClientes
    end

end
