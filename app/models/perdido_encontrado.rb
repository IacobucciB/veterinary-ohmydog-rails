class PerdidoEncontrado < ApplicationRecord
  belongs_to :perro

  enum tipo: { Perdido: 1 }
  enum estado: { Busqueda: 1, Hallado: 2}

  validates :zona, presence: true
  validates :dia, presence: true
  validates :observacion, presence: true
  validates :estado, presence: true, inclusion: { in: estados.keys }
  validates :tipo, presence: true, inclusion: { in: tipos.keys }

  validate :dia_no_futuro

  private

  def dia_no_futuro
    if dia.present? && dia > Date.current
      errors.add(:dia, "no puede ser en el futuro")
    end
  end

end
