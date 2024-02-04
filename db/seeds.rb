# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Turno.destroy_all
TipoTurno.destroy_all
Perro.destroy_all
Persona.destroy_all
User.destroy_all
Paseador.destroy_all
Plaza.destroy_all
CampaniaDonacion.destroy_all


usuarioPedro = User.create
usuarioPedro.email = "ohmydog_veterinaria@gmail.com"
usuarioPedro.password = "Veterinaria1+"
usuarioPedro.role = 1
usuarioPedro.save

usuario = User.create
usuario.email = "johndoe@gmail.com"
usuario.password = "654321+aA"
usuario.role = 0
usuario.save

usuarioMirtha = User.create
usuarioMirtha.email = "mirtha@gmail.com"
usuarioMirtha.password = "123456+aA"
# usuarioMirtha.is_active = false
usuarioMirtha.role = 0
usuarioMirtha.save

usuarioLuna = User.create
usuarioLuna.email = "luna@gmail.com"
usuarioLuna.password = "123456+aA"
# usuarioLuna.is_active = false
usuarioLuna.role = 0
usuarioLuna.save

pedro = Persona.create
pedro.nombre = "Pedro"
pedro.apellido = "Meza"
pedro.dni = 1111
pedro.telefono = 221444
pedro.nacimiento = Date.new(1995, 5, 15)
pedro.donante = true
pedro.user_id = usuarioPedro.id
pedro.save

john = Persona.create
john.nombre = "John"
john.apellido = "Doe"
john.dni = 2222
john.telefono = 221555
john.nacimiento = Date.new(2000, 5, 15)
john.donante = false
john.user_id = usuario.id
john.save

mirtha = Persona.create
mirtha.nombre = "Mirtha"
mirtha.apellido = "Mezasa"
mirtha.dni = 111112
mirtha.telefono = 221444
mirtha.nacimiento = Date.new(1995, 5, 15)
mirtha.donante = true
mirtha.user_id = usuarioMirtha.id
mirtha.save

luna = Persona.create
luna.nombre = "Luna"
luna.apellido = "Cuervo"
luna.dni = 41881372
luna.telefono = 2214810392
luna.nacimiento = Date.new(1999, 9, 8)
luna.donante = false
luna.user_id = usuarioLuna.id
luna.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Mestizo"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Labrador Retriever"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Pastor Alemán"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Golden Retriever"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Bulldog Francés"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Bulldog"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Caniche"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Beagle"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Rottweiler"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Yorkshire Terrier"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Teckel"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Husky Siberiano"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Boxer"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Labrador"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Golden"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Gran Danés"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Chihuahua"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Pastor de Shetland"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Pastor Australiano"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Border Collie"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Dálmata"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Cocker Spaniel"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Schnauzer Miniatura"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Siberiano"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Boston Terrier"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Carlino"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Bulldog Inglés"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Salchicha"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "San Bernardo"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Pomerania"
tipoRaza.save

tipoRaza = TipoRaza.create
tipoRaza.nombre = "Perro Pastor Australiano"
tipoRaza.save

perro = Perro.create
perro.nombre = "Rex"
perro.edad = 5
perro.color = "Caramelo"
perro.descripcion = "Energico y jueguetón"
perro.antecedentes = "Rescatado de la calle"
perro.persona_id = john.id
perro.tipo_raza_id = tipoRaza.id
perro.sexo = 1
perro.save

perroFirix = Perro.create
perroFirix.nombre = "Firix"
perroFirix.edad = 3
perroFirix.color = "Negro esperanza"
perroFirix.descripcion = "Es vago y duerme 10 horas"
perroFirix.antecedentes = "De la calle"
perroFirix.persona_id = john.id
perroFirix.tipo_raza_id = tipoRaza.id
perroFirix.sexo = 0
perroFirix.save


perroHaku = Perro.create
perroHaku.nombre = "Haku"
perroHaku.edad = 7
perroHaku.color = "Marron Canela"
perroHaku.descripcion = "No convive con otros perros"
perroHaku.antecedentes = "Esta castrado"
perroHaku.persona_id = mirtha.id
perroHaku.tipo_raza_id = 24
perroHaku.sexo = 0
perroHaku.save


perroBachicha = Perro.create
perroBachicha.nombre = "Bachicha"
perroBachicha.edad = 7
perroBachicha.color = "Negro y marron"
perroBachicha.descripcion = "Toma solcito a la orilla del mar"
perroBachicha.antecedentes = "Vacuna antirrabica"
perroBachicha.persona_id = usuarioMirtha.id
perroBachicha.tipo_raza_id = 28
perroBachicha.sexo = 1
perroBachicha.save

perroCarbol = Perro.create
perroCarbol.nombre = "Carbon"
perroCarbol.edad = 6
perroCarbol.color = "Negro"
perroCarbol.descripcion = "Compañero"
perroCarbol.antecedentes = "No tiene"
perroCarbol.persona_id = usuarioLuna.id
perroCarbol.tipo_raza_id = 28
perroCarbol.sexo = 0
perroCarbol.save

perroFatiga = Perro.create
perroFatiga.nombre = "Fatiga"
perroFatiga.edad = 24
perroFatiga.color = "Marron Claro"
perroFatiga.descripcion = "Muy dormilon"
perroFatiga.antecedentes = "No tiene"
perroFatiga.persona_id = usuarioLuna.id
perroFatiga.tipo_raza_id = 1
perroFatiga.sexo = 0
perroFatiga.save

tipoTurno = TipoTurno.create
tipoTurno.nombre = "Vacuna tipo A"
tipoTurno.save

tipoTurno = TipoTurno.create
tipoTurno.nombre = "Vacuna tipo B"
tipoTurno.save

tipoTurno = TipoTurno.create
tipoTurno.nombre = "Urgencia"
tipoTurno.save

tipoTurno = TipoTurno.create
tipoTurno.nombre = "Desparasitacion"
tipoTurno.save

tipoTurno = TipoTurno.create
tipoTurno.nombre = "Castracion"
tipoTurno.save

tipoTurno = TipoTurno.create
tipoTurno.nombre = "Atencion"
tipoTurno.save


#este es de atencion, lo uso para ver el confirmar turno y tambien para mostrar que
#no puedo marcar como presente un turno futuro
turno = Turno.create
turno.dia = Date.today+1
turno.franja_horaria = 1
turno.estado = 0
turno.perro_id = perro.id
turno.tipo_turno_id = 6
turno.save

turno = Turno.create
turno.dia = Date.today+1
turno.franja_horaria = 0
turno.estado = 0
turno.perro_id = perroFirix.id
turno.tipo_turno_id = 4
turno.save

# #desparacitación
# turno = Turno.create
# turno.dia = Date.today
# turno.franja_horaria = 0
# turno.estado = 0
# turno.perro_id = perroFirix.id
# turno.tipo_turno_id = 4
# turno.save

# que no te deje marcar presente un turno futuro
#este no deberia porque es franja tarde
turnoTardeHoy = Turno.create
turnoTardeHoy.dia = Date.today
turnoTardeHoy.franja_horaria = 1
turnoTardeHoy.estado = 1
turnoTardeHoy.perro_id = perro.id
turnoTardeHoy.tipo_turno_id = 2
turnoTardeHoy.hora = Time.parse("19:30:00")
turnoTardeHoy.save

#este si se puede
turnoManianaHoy = Turno.create
turnoManianaHoy.dia = Date.today
turnoManianaHoy.franja_horaria = 0
turnoManianaHoy.estado = 1
turnoManianaHoy.perro_id = perro.id
turnoManianaHoy.tipo_turno_id = 2
turnoManianaHoy.hora = Time.parse("11:30:00")
turnoManianaHoy.save

#mostrar desparacitacion que se ve bien
#por que con haku no se puede?
turnoDesparacitacion = Turno.create
turnoDesparacitacion.dia = Date.today
turnoDesparacitacion.franja_horaria = 0
turnoDesparacitacion.estado = 1
turnoDesparacitacion.perro_id = perro.id
turnoDesparacitacion.tipo_turno_id = 4
turnoDesparacitacion.hora = Time.parse("11:00:00")
turnoDesparacitacion.save

# turno = Turno.create
# turno.dia = Date.today
# turno.franja_horaria = 1
# turno.estado = 0
# turno.perro_id = 1
# turno.tipo_turno_id = 6
# turno.save

turnoCastracion = Turno.create
turnoCastracion.dia = Date.new(2023,11,20)
turnoCastracion.franja_horaria = 0
turnoCastracion.estado = 3
turnoCastracion.perro_id = 3
turnoCastracion.tipo_turno_id = 5
turnoCastracion.monto = 25000
turnoCastracion.descripcion = "Salio todo perfecto"
turnoCastracion.save(validate: false)

turnoCastracion2 = Turno.create
turnoCastracion2.dia = Date.new(2023,11,20)
turnoCastracion2.franja_horaria = 0
turnoCastracion2.estado = 3
turnoCastracion2.perro_id = 5
turnoCastracion2.tipo_turno_id = 5
turnoCastracion2.monto = 25000
turnoCastracion2.descripcion = "Castracion 0 km"
turnoCastracion2.save(validate: false)

turnoViejo = Turno.create
turnoViejo.dia = Date.new(2023,11,10)
turnoViejo.franja_horaria = 0
turnoViejo.estado = 3
turnoViejo.perro_id = 3
turnoViejo.tipo_turno_id = 6
turnoViejo.monto = 3000
turnoViejo.descripcion = "Se le cortaron las uñas"
turnoViejo.save(validate: false)

turnoViejo2 = Turno.create
turnoViejo2.dia = Date.new(2023,12,10)
turnoViejo2.franja_horaria = 0
turnoViejo2.estado = 3
turnoViejo2.perro_id = 3
turnoViejo2.tipo_turno_id = 6
turnoViejo2.monto = 30000
turnoViejo2.descripcion = "Placa de patita"
turnoViejo2.save(validate: false)
#aplicar desparacitacion HAKU
# turnoDesparacitacion = Turno.create
# turnoDesparacitacion.dia = Date.today
# turnoDesparacitacion.franja_horaria = 0
# turnoDesparacitacion.estado = 1
# turnoDesparacitacion.perro_id = 3
# turnoDesparacitacion.tipo_turno_id = 4
# turnoDesparacitacion.save

campania = CampaniaDonacion.create
campania.nombre = "Refugio Titucha "
campania.descripcion = "El refugio Titucha que se encuentra ubicado en La Plata y necesitan ayuda monetaria para comprar Vacunas Antirábicas."
campania.fecha_final = DateTime.now + 1.month
campania.monto_objetivo = 20000
campania.monto_actual = 0
campania.save

campaniaFinalizada = CampaniaDonacion.create
campaniaFinalizada.nombre = "Perro atropellado"
campaniaFinalizada.descripcion = "Encontramos en la ciudad un perro atropellado y abandonado, requerimos de su ayuda para su operación y pronta recuperación."
campaniaFinalizada.fecha_final = DateTime.new(2023,11,30)
campaniaFinalizada.monto_objetivo = 100000
campaniaFinalizada.monto_actual = 100000
campaniaFinalizada.save

tarjeta_credito1 = TarjetaCredito.create
tarjeta_credito1.nombre = 'John Doe'
tarjeta_credito1.numero = "1111222233334444"
tarjeta_credito1.fecha_vencimiento = Date.new(2028, 06, 01)
tarjeta_credito1.codigo_seguridad = 123
tarjeta_credito1.saldo = 200000
tarjeta_credito1.save

plaza1 = Plaza.create(nombre: 'Moreno')
plaza2 = Plaza.create(nombre: 'España')
plaza3 = Plaza.create(nombre: 'Italia')
plaza4 = Plaza.create(nombre: 'Azcuénaga')

paseador1 = Paseador.create(name: 'Juan Pérez', service_type: 0, email: 'paseadorJuan@gmail.com', plaza_id: plaza1.id)
paseador2 = Paseador.create(name: 'Valentina Fernandez', service_type: 0, email: 'paseosValentina@gmail.com', plaza_id: plaza2.id)
paseador3 = Paseador.create(name: 'Antonella Sani', service_type: 0, email: 'paseadoraAnto@gmail.com', plaza_id: plaza3.id)
paseador4 = Paseador.create(name: 'Melina Díaz', service_type: 1, email: 'cuidadoraMelina@gamil.com', location: '1 y 47 nro 7')
paseador5 = Paseador.create(name: 'Nacho Cuervo', service_type: 1, email: 'cuidadorNacho@gmail.com', location: '462 nro 1360')

#turno futuro  PENDIENTE Y ACEPTADO para carbon de luna que se va a dar de baja al PERRO
turnoCarbon = Turno.create
turnoCarbon.dia = Date.new(2023,12,20)
turnoCarbon.hora = Time.parse("11:30:00")
turnoCarbon.franja_horaria = 0
turnoCarbon.estado = 1
turnoCarbon.perro_id = 5
turnoCarbon.tipo_turno_id = 6
turnoCarbon.save

turnoCarbona5 = Turno.create
turnoCarbona5.dia = Date.new(2023,12,20)
turnoCarbona5.franja_horaria = 0
turnoCarbona5.estado = 0
turnoCarbona5.perro_id = 5
turnoCarbona5.tipo_turno_id = 6
turnoCarbona5.save(validate: false)
# turnoCastracion2.save(validate: false)

turnoFatiga = Turno.create
turnoFatiga.dia = Date.new(2023,12,20)
turnoFatiga.franja_horaria = 0
turnoFatiga.estado = 1
turnoFatiga.perro_id = perroFatiga.id
turnoFatiga.tipo_turno_id = 6
turnoFatiga.save

puts "Seeded database"
