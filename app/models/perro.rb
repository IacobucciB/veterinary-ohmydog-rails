class Perro < ApplicationRecord
    belongs_to :persona
    enum sexo: { Hembra: 0, Macho: 1 }
    has_many :turno
    belongs_to :tipo_raza
    has_one_attached :foto
    has_one :perdido_encontrado

    validates :nombre, format: { with: /\A[a-zA-Z\s]+\z/, message: "Solo se permiten letras en el nombre." }
    validates :edad, numericality: { only_integer: true, message: "La edad debe contener solo números." }
    validates :color, format: { with: /\A[a-zA-Z\s]+\z/, message: "Solo se permiten letras en el color." }
    validates :antecedentes, format: { with: /\A[a-zA-Z\s]+\z/, message: "Solo se permiten letras en los antecedentes." }
    validates :nombre, uniqueness: { scope: :persona_id, message: "No puede tener dos perros con el mismo nombre" }

    before_create :set_default_active_status

    def nombre_con_dueno
      "#{nombre} - #{persona.nombre} #{persona.apellido}"
    end

    def set_default_active_status
      self.is_active ||= true
      self.is_lost ||= false
    end

    def tiene_turnos_pendientes?
      turno.where(estado: ['pendiente', 'aceptado']).exists?
    end
    
    def turnos_pendientes_count
      turno.where(estado: ['pendiente', 'aceptado']).count
    end
    
    def self.perros_activos
      where(is_active: true, is_lost: false)
    end
end
