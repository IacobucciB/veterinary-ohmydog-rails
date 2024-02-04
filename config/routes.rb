Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/homeVeterinario' => "veterinarios#homeVeterinario"
  get '/homeClientes' => "clientes#homeClientes"

  # get '/registrarCliente', to: 'personas#new_user_and_persona'
  get '/registrarCliente', to: 'personas#new_user_and_persona', as: 'new_user_and_persona'
  post '/registrarCliente', to: 'personas#create_user_and_persona'

  get '/mi_perfil/:id', to: 'personas#show_mydata', as: 'show_my_data'

  get '/personas/:persona_id/perros/personaperro', to: 'perros#personaperro', as: 'persona_perros_personaperro'
  get '/personas/:id/datos_personales', to: 'personas#datos_personales', as: 'persona_datos_personales'

  get '/index/:id/ver_info_perro', to: 'perros#ver_info_perro', as: 'ver_info_perro'

  get '/turnos_del_dia', to: 'turnos#turnos_del_dia', as: 'turnos_del_dia'

  get 'turnos/:id/aceptar', to: 'turnos#aceptar', as: 'aceptar_turno'
  post 'procesar_aceptar/:id', to: 'turnos#procesar_aceptar', as: 'procesar_aceptar_turno'
  get 'turnos/:id/rechazar', to: 'turnos#rechazar', as: 'rechazar_turno'
  post 'procesar_rechazar/:id', to: 'turnos#procesar_rechazar', as: 'procesar_rechazar_turno'

  post 'perroEncontrado/:id', to: 'perdido_encontrados#marcar_encontrado', as: 'marcar_encontrado'

  get 'turnos_del_dia/:id', to: 'turnos#ausente', as: 'ausente_turno'
  get 'turnos_del_dia/:id/presente', to: 'turnos#presente', as: 'presente_turno'
  # resources :tipo_turnos
  get '/index/:id/ver_info_perro/historia_clinica', to: 'perros#historia_clinica', as: 'historia_clinica_perro'
  get '/index/:id/ver_info_perro/libreta_sanitaria', to: 'perros#libreta_sanitaria', as: 'libreta_sanitaria_perro'

  get '/personas/:id/editar', to: 'personas#editar', as: 'personas_editar'
  patch '/personas/:id/editar', to: 'personas#update', as: 'actualizar_mi_perfil'

  get '/turnos/subirUrgencia', to: 'turnos#newUrgencia', as: 'new_urgencia'
  post '/turnos/subirUrgencia', to: 'turnos#createUrgencia'

  get '/turnosAll', to: 'turnos#mostrarTodos', as: 'turnos_todos'

  get '/nueva_campania', to: 'campania_donacions#new', as: 'nueva_campania'
  post '/crear_campania', to: 'campania_donacions#create', as: 'crear_campania'

  get '/vista_veterinario', to: 'campania_donacions#vistaVeterinario', as: 'vista_veterinario'

  get '/editar_campania/:id', to: 'campania_donacions#editar', as: 'editar_campania'

  get '/ver_campanias', to: 'campania_donacions#vistaUsuario', as: 'ver_campanias'

  get '/ver_campanias_publico', to: 'campania_donacions#vistaPublica', as: 'ver_campanias_publico'

  get '/ver_campanias/:id/donar', to: 'tarjeta_creditos#donar', as: 'donar'
  get '/ver_campanias/:id/donarVisitante', to: 'tarjeta_creditos#donarVisitante', as: 'donar_visitante'
  # post 'campanias/:id/procesar_donacion', to: 'campanias#procesar_donacion', as: 'procesar_donacion_campania'
  post '/procesar_dono', to: 'tarjeta_creditos#procesar_dono', as: 'procesar_dono'
  post '/procesar_visitante', to: 'tarjeta_creditos#procesar_dono_visitante', as: 'procesar_dono_visitante'

  get '/historial_gastos', to: 'turnos#historial_gastos', as: 'historial_gastos'

  get '/get_perros_by_persona', to: 'turnos#get_perros_by_persona'

  get '/ver_paseadores_publico', to: 'paseadors#index_paseador_guest', as: 'index_paseador_guest'

  get '/ver_paseadores', to: 'paseadors#index_paseador_usuario', as: 'index_paseador_usuario'

  get '/ver_paseadores_veterinario', to: 'paseadors#index_paseador_veterinario', as:'index_paseador_veterinario'

  # get '/nuevo_paseador', to: 'paseadors#new', as: 'nuevo_paseador'
  # post '/crear_paseador', to: 'paseadors#create', as: 'crear_paseador'

  get '/newPaseador', to: 'paseadors#newPaseador', as: 'new_paseador'
  post '/create_paseador', to: 'paseadors#createPaseador', as: 'create_paseador'
  get '/newCuidador', to: 'paseadors#newCuidador', as: 'new_cuidador'
  post '/create_cuidador', to: 'paseadors#createCuidador', as: 'create_cuidador'

  get '/perdido_encontrado_nuevo', to: 'perdido_encontrados#new', as: 'nuevo_perdido_encontrado'
  post '/crear_perdido_encontrado', to: 'perdido_encontrados#create', as: 'crear_perdido_encontrado'

  get '/encontrado_nuevo', to: 'encontrados#new', as: 'nuevo_encontrado'
  post '/crear_encontrado', to: 'encontrados#create', as: 'crear_encontrado'
  resources :encontrados

  get '/perdido_encontrado_usuario', to: 'perdido_encontrados#perdido_encontrado_usuario', as:'perdido_encontrado_usuario'

  get '/encontrado_usuario', to: 'encontrados#index_encontrado_usuario', as:'index_encontrado_usuario'

  get '/perdido_encontrado_visitante', to: 'perdido_encontrados#perdido_encontrado_visitante', as: 'perdido_encontrado_visitante'

  get '/perdido_mis_publicaciones', to: 'perdido_encontrados#mis_publicaciones_perdidos', as: 'mis_publicaciones_perdidos'

  get '/mis_publicaciones_encontrados', to: 'encontrados#mis_publicaciones_encontrados', as: 'mis_publicaciones_encontrados'

  get '/vista_visitantes_encontrados', to: 'encontrados#index_encontrado_visitante', as: 'index_encontrado_visitante'

  get '/paseadores/:id/editar', to: 'paseadors#edit', as: 'paseadors_editar'
  patch '/paseadores/:id/editar', to: 'paseadors#update', as: 'actualizar_paseadors'

  get '/perdidos/reencuentros', to: 'perdido_encontrados#show_reencuentros', as: 'perros_perdidos_y_encontrados'

  # patch '/mi_perfil/:id/actualizar', to: 'personas#update', as: 'actualizar_mi_perfil'

  resources :campania_donacions, only:[:new, :create, :vistaVeterinario, :editar, :update, :vistaUsuario]

  resources :perdido_encontrados, only:[:new, :create, :perdido_encontrado_usuario, :perdido_encontrado_visitante, :mis_publicaciones_perdidos]

  resources :encontrados, only:[:new, :create, :index_encontrado_usuario, :mis_publicaciones_encontrados, :index_encontrado_visitante]

  resources :paseadors, only:[:new, :create, :index_paseador_guest, :index_paseador_usuario, :index_paseador_veterinario, :edit, :update]

  resources :tarjeta_creditos, only:[:new, :index, :create, :edit, :update, :destroy, :informacion_correcta, :donar]

  resources :perros, only: [:new, :create, :index, :personaperro, :ver_info_perro]

  resources :turnos, only: [:new, :create, :show, :index, :turnos_del_dia, :update, :historial_gastos, :get_perros_by_persona]

  resources :personas, only: [:new, :create, :index, :editar, :update]

  resources :personas, only: [:new, :create, :index, :edit, :update] do
    resources :perros, only: [:personaperro, :new, :create]  # Agrega ruta anidada solo para la acción index de perros
  end

  post '/personas/:id/baja', to: 'veterinarios#baja_logica_cliente', as: 'baja_persona'
  post '/perros/:id/baja', to: 'personas#baja_logica_perro', as: 'baja_perro'

  get '/under_construction', to: 'application#under_construction'

  get '/turnos/:id/historiaClinica', to: 'turnos#show_turno_historiaClinica', as: 'show_turno_historia'
  get '/turnos/:id/libretaSanitaria', to: 'turnos#show_turno_libretaSanitaria', as: 'show_turno_libreta'

  get '/adopciones', to: 'adopcions#index', as: 'adopciones_index'
  # get '/home/adopciones', to: 'adopcions#adopcionesVisitante', as: 'adopciones_index_visitante'

  get '/adopciones/publicar/:id', to: 'adopcions#new', as: 'adopciones_publicacion_new'
  post 'adopciones/publicar', to: 'adopcions#create', as: 'adopciones_post_publicacion_new'
  get '/adopciones/:id/publicaciones', to: 'adopcions#mis_publicaciones', as: 'adopciones_mis_publicaciones'

  get '/adopciones/publicar_mi_perro/:id', to: 'adopcions#new_mi_perro', as: 'adopciones_publicacion_new_mi_perro'
  post 'adopciones/publicar_mi_perro', to: 'adopcions#create_mi_perro', as: 'adopciones_post_publicacion_new_mi_perro'
  resources :adopcions  # Add this line

  get '/adopciones/:id/contactar', to: 'adopcions#adoptar', as: 'mail_adopcion'
  post '/adopciones/:id/contactar', to: 'adopcions#adoptar_datos'

  post '/adopciones/:id/adoptado', to: 'adopcions#marcar_adoptado', as: 'marcar_adoptado'
  post '/encontrados/:id/recuperado', to: 'encontrados#marcar_recuperado', as: 'marcar_recuperado'

  #root to: 'application#home'
  root 'application#determine_root'

  # match "*path", to: "application#under_construction", via: :all
end
