class Encontrado < ApplicationRecord
  belongs_to :user
  enum tamanio: { Chico: 1, Mediano: 2, Grande: 3}
  enum estado: {Encontrado: 0, Hallado: 1}

  validate :dia_no_futuro
  validates :lugar, presence: true
  validates :color, presence: true
  validates :tamanio, presence: true
  validates :dia, presence: true
  validates :descripcion, presence: true
  validates :estado, presence: true, inclusion: { in: estados.keys }

  private

  def dia_no_futuro
    if dia.present? && dia > Date.current
      errors.add(:dia, "no puede ser en el futuro")
    end
  end
end
