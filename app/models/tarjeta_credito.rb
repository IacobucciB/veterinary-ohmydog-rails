class TarjetaCredito < ApplicationRecord
  validates :numero, presence: true, length: { is: 16 }
  validates :nombre, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "Solo se permiten letras en el nombre." }
  validates :fecha_vencimiento, presence: true
  validates :codigo_seguridad, presence: true, length: { is: 3 }
  validates :saldo, presence: true, numericality: { greater_than_or_equal_to: 0 }


end
