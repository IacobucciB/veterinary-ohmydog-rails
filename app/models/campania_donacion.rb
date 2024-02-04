class CampaniaDonacion < ApplicationRecord
  validate :fecha_final_valida
  validates :nombre, presence: { message: "El campo está vacío" }
  validates :descripcion, presence: { message: "El campo está vacío" }

  # Nuevos campos
  validates :monto_actual, numericality: { greater_than_or_equal_to: 0, message: "Debe ser un número no negativo" }
  validates :monto_objetivo, numericality: { greater_than_or_equal_to: 0, message: "Debe ser un número no negativo" }

  private

  def fecha_final_valida
    if fecha_final.present? && fecha_final < DateTime.now
      errors.add(:fecha_final, "La fecha final debe ser para un día futuro.")
    end
  end
end
