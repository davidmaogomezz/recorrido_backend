# Instrucciones

1. Clonar este repositorio
1. Instalar PostgreSQL
1. En la raíz del proyecto ejecutar `bootstrap.sh` junto con el nombre el proyecto `./bootstrap.sh recorrido_backend`
1. crear variables de entorno `export DB_NAME=recorrido_backend` `export DB_USER=` `export DB_PASSWROD=`
1. rubocop -A && rspec -f d
1. `rails s`

Este proyecto fue creado partiendo de [rails api base](https://github.com/rootstrap/rails_api_base)

# Modelo entidad relación

![modelo entidad relación](https://res.cloudinary.com/job-run/image/upload/v1660882522/Captura_de_Pantalla_2022-08-18_a_la_s_11.14.43_p._m._qyn3mu.png)

Tenemos 3 tipos de usuarios:
1. Client
2. Admin
3. Expert

# El usuario Cliente puede:
1. Crear Contratos. Específica el período durante el cual estará vigente, los días y horas en los que necesitará que se le preste el servicio (mantenedor no desarrollo en la vista).
2. Se puede loguear en la plataforma web y filtrar por contrato y semana para ver los turnos junto con el experto al cual fue asignado el turno


# El usuario Admin puede:
1. Aprobar el contrato creado por el cliente. (mantenedor no desarrollado)
    Si el contrato es aprobado se activa un callback llamado create_turns en el modelo ```contract.rb``` este callback nos va a crear todos los turnos pactados en el contrato
2. Puede ingresar a la vista de turnos asignados y la vista de asignar disponibilidad de turnos. En la vista de disponibilidad de turnos el usuario admin puede decir cuales expertos están disponibles para determinado turno pero no puede asignar el turno a un determinado experto, esto lo hace el algoritmo de asignación de turnos.

# El usuario Expert puede
1. Puede ingresar a la vista de turnos asignados
2. Puede marcar/desmarcar solo su disponibilidad y ver la de otros expertos

# Algoritmo de asignación de turnos:
 1. Calculamos la carga laboral de cada experto.
 2. Si todos los expertos posibles para un turno están asignados como disponibles para ese turno, hacemos la asignación del turno al expertor que tenga menor carga laboral.
 3. Si se encuentra que todos los expertos disponibles para un turno tienen la misma carga laboral la asignación se hace de manera aleatoria. 
 4. Si faltando una hora para que el turno entre en vigencia el turno no tiene ningún experto marcado como disponible se ejecuta un rake task que asigna el turno según la logica mencionada en los literales 2 y 3.

 # Este proyecto se puede ver en funcionamiento en [recorrido-front](https://recorrido-front.onrender.com/)

Se puede ingresar con cualquiera de los siguientes usuarios

| email            | contraseña | role  |
|:----------------:|------------|-------|
| admin@mail.com   | 12345678   | Admin |
| expert1@mail.com | 12345678   | Expert|
| expert2@mail.com | 12345678   | Expert|
| expert3@mail.com | 12345678   | Expert|
| client1@mail.com | 12345678   | Expert|
| client2@mail.com | 12345678   | Expert|
| client3@mail.com | 12345678   | Expert|