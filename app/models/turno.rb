class Turno < ApplicationRecord
    belongs_to :perro
    enum franja_horaria: { am: 0, pm: 1 }
    enum estado: { pendiente: 0, aceptado: 1, rechazado: 2, presente: 3, ausente: 4, cancelado: 5 }
    belongs_to :tipo_turno

    # validates :peso, :dosis, presence: {message: "El campo no puede ser nulo."}
    validate :turno_duplicado
    validate :edad_minima_vacuna_tipo_a
    validate :edad_minima_vacuna_tipo_b
    validate :edad_minima_castracion
    validate :castracion_doble, if: :castracion_turno_created?
    validate :fecha_valida

    private
    def turno_duplicado
        existing_turno = Turno.find_by(tipo_turno_id: tipo_turno_id, perro_id: perro_id)
        if existing_turno && existing_turno.id != id && existing_turno.estado == 'pendiente'
          errors.add(:base, "Ya tiene un turno pendiente de confirmación para este tipo de turno")
        end
    end

    def edad_minima_vacuna_tipo_a
        turno = Turno.find_by(tipo_turno_id: tipo_turno_id, perro_id: perro_id)
        perro = Perro.find_by(id: perro_id)
        tipo_turno = TipoTurno.find_by(id: tipo_turno_id)
        if tipo_turno && tipo_turno.nombre == "Vacuna tipo A" && perro.edad < 2
            errors.add(:base, "No se puede programar una Vacuna tipo A para un perro con menos de 2 meses.")
        end
    end

    def edad_minima_vacuna_tipo_b
        turno = Turno.find_by(tipo_turno_id: tipo_turno_id, perro_id: perro_id)
        perro = Perro.find_by(id: perro_id)
        tipo_turno = TipoTurno.find_by(id: tipo_turno_id)
        if tipo_turno && tipo_turno.nombre == "Vacuna tipo B" && perro.edad < 4
            errors.add(:base, "No se puede programar una Vacuna tipo B para un perro con menos de 4 meses.")
        end
    end

    def edad_minima_castracion
        turno = Turno.find_by(tipo_turno_id: tipo_turno_id, perro_id: perro_id)
        perro = Perro.find_by(id: perro_id)
        tipo_turno = TipoTurno.find_by(id: tipo_turno_id)
        if tipo_turno && tipo_turno.nombre == "Castracion" && perro.edad < 6
            errors.add(:base, "No se puede programar una Castración para un perro con menos de 6 meses.")
        end
    end

    def fecha_valida
        if dia.present? && dia < Date.today
          errors.add(:dia, "La fecha del turno debe ser para un día futuro.")
        end
    end

    def castracion_turno_created?
        # Add conditions here based on your application logic
        # For example, check if the tipo_turno is castration and it's a new record
        tipo_turno_id_changed? && tipo_turno.nombre == "Castracion" && new_record?
    end

    def castracion_doble
        existing_castracion_turno = Turno.find_by(perro_id: perro_id, tipo_turno_id: TipoTurno.find_by(nombre: "Castracion").id, estado: ['aceptado', 'presente', 'pendiente'])
        puts existing_castracion_turno.id
        puts id
        if existing_castracion_turno #&& existing_castracion_turno.id != id
            if existing_castracion_turno.estado == 'pendiente'
                existing_castracion_turno = nil
                errors.add(:base, "No se puede programar otro turno de 'Castracion' para un perro que ya tiene uno pendiente.")
            else
                errors.add(:base, "No se puede programar otro turno de 'Castracion' para un perro que ya esta castrado.")
            end
        end
    end

end
