class Paseador < ApplicationRecord
  enum service_type: { paseador: 0, cuidador: 1 }

  validates :name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "Solo se permiten letras en el nombre." }
  validates :service_type, presence: true, inclusion: { in: service_types.keys, message: "Tipo de servicio no válido" }
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "Formato de correo electrónico no válido" }
  validates :email, uniqueness: { message: "Este mail ya esta registrado en el sistema. Pruebe con otro."}

  validates :plaza_id, presence: true, if: -> { service_type == "paseador" }
  validates :location, presence: true, if: -> { service_type == "cuidador" }
end
