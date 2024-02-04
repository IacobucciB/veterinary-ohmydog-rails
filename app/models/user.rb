class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  has_one :persona
  has_many :encontrados

  validates :email, uniqueness: { message: "El email ya se encuentra registrado en el sistema" }
  validates :email, presence: { message: "El email no puede ser nulo"}, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "El formato del email no es válido" }
  validates :password, presence: { message: "La contraseña no puede ser nula"}, length: { minimum: 6, message: "La contraseña debe tener al menos 6 caracteres" }, format: { with: /\A(?=.*\d)(?=.*[a-z])(?=.*)(?=.*[a-z]).{6,}\z/, message: "La contraseña debe contener al menos un número y un símbolo" }

  before_create :set_default_active_status
  after_initialize :set_default_role, if: :new_record?
  enum role: {cliente: 0, admin: 1}

  private
  def set_default_role
    self.role ||= :cliente
  end

  def set_default_active_status
    self.is_active ||= true
  end
end
