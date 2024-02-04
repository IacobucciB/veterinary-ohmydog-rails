class Persona < ApplicationRecord
  has_many :perros
  has_many :adopcions, dependent: :destroy
  belongs_to :user
  validates :nombre, :apellido, :nacimiento, :telefono, :dni, presence: {message: "El campo no puede ser nulo."}
  validates :nombre, format: { with: /\A[a-zA-Z\s]+\z/, message: "Solo se permiten letras en el nombre." }
  validates :apellido, format: { with: /\A[a-zA-Z\s]+\z/, message: "Solo se permiten letras en el apellido." }
  validate :age_must_be_over_18s
  validates :dni, uniqueness: { message: "El dni ya se encuentra registrado en el sistema." }, unless: -> { dni_unchanged? }
  validates :telefono, numericality: { only_integer: true, message: "El teléfono debe contener solo números." }
  after_initialize :set_default_donante, if: :new_record?
  validates :user_id, presence: true
  private

  def age_must_be_over_18s
    if nacimiento.present? && nacimiento > 18.years.ago.to_date
      errors.add(:nacimiento, "El cliente que intenta registrar es menor de 18 años.")
    end
  end

  def set_default_donante
    self.donante ||= :false
  end

  def dni_unchanged?
    persisted? && changes[:dni].nil?
  end

  public
  def perros_con_turnos_pendientes
    perros.select { |perro| perro.tiene_turnos_pendientes? }
  end

  # def perros_con_turnos_pendientes_detalles
  #   perros_con_turnos_pendientes.map do |perro|
  #     "#{perro.nombre}: #{perro.turno.where(estado: 'pendiente').count} turnos pendientes"
  #   end
  # end

  def perros_con_turnos_pendientes_detalles
    detalles = perros_con_turnos_pendientes.map do |perro|
      "#{perro.nombre}: #{perro.turno.where(estado: ['pendiente', 'aceptado']).count} turnos pendientes."
    end
    detalles.join("\n")
  end
  

end
