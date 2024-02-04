class Adopcion < ApplicationRecord
    belongs_to :persona
    belongs_to :tipo_raza
    enum sexo: { Hembra: 0, Macho: 1 }
    enum tamanio: { Chico: 0, Mediano: 1, Grande: 2}
    enum estado: { Publicado: 0, Adoptado: 1 }

    validates :tipo_raza, :sexo, :tamanio, :origen, presence: {message: "Complete este campo por favor."}
end
