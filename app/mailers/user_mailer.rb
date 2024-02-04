class UserMailer < ApplicationMailer
  def example(user, random_password)
    @user = user
    @random_password = random_password
    mail(to: @user.email, subject: 'Cambio de Contraseña')
  end

  def turno_vacunaa(user, tipoturnoid, perroid, eldia)

    @user = user
    @tipoturnoid = tipoturnoid
    @perroid = perroid
    @eldia = eldia
    @tipoturno = TipoTurno.find(@tipoturnoid)
    @perro = Perro.find(@perroid)
    mail(to: @user.email, subject: 'Nuevo turno 21 dias despues')

  end


  def turno_vacuna_anual(user, tipoturnoid, perroid, eldia, lahora, franja)

    @user = user
    @tipoturnoid = tipoturnoid
    @perroid = perroid
    @eldia = eldia
    @lahora = lahora
    @franja = franja
    @tipoturno = TipoTurno.find(@tipoturnoid)
    @perro = Perro.find(@perroid)
    mail(to: @user.email, subject: 'Nuevo turno para refuerzo anual')

  end

  def turno_pend(user, tipoturnoid, perroid, eldia)
    @user = user
    @tipoturnoid = tipoturnoid
    @perroid = perroid
    @eldia = eldia
    @tipoturno = TipoTurno.find(@tipoturnoid)
    @perro = Perro.find(@perroid)
    mail(to: @user.email, subject: 'Turno Pendiente de Confirmacion')
  end

  def turno_aceptado(user, tipoturnoid, perroid, eldia, franja_horaria, texto, hora)
    @user = user
    @tipoturnoid = tipoturnoid
    @perroid = perroid
    @eldia = eldia
    @franja_horaria = franja_horaria
    @tipoturno = TipoTurno.find(@tipoturnoid)
    @perro = Perro.find(@perroid)
    @texto=texto
    @hora=hora
    mail(to: @user.email, subject: 'Turno Confirmado')
  end

  def turno_rechazado(user, tipoturnoid, perroid, eldia, franja_horaria, texto)
    @user = user
    @tipoturnoid = tipoturnoid
    @perroid = perroid
    @eldia = eldia
    @franja_horaria = franja_horaria
    @tipoturno = TipoTurno.find(@tipoturnoid)
    @perro = Perro.find(@perroid)
    @texto=texto
    mail(to: @user.email, subject: 'Turno Rechazado')
  end

  def adopcion_contactar(user, nombreDuenio, apellidoDuenio, nombre, apellido, telefono, email, razon, publicacion)
    @user = user
    @nombreDuenio = nombreDuenio
    @apellidoDuenio = apellidoDuenio
    @nombre = nombre
    @apellido = apellido
    @telefono = telefono
    @email = email
    @razon = razon
    @publicacion = publicacion
    mail(to: @user.email, subject: 'Mail de contacto enviado. Espere a la brevedad la respuesta del dueño.')
  end
end
