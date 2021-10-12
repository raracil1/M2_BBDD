EJERCICIO 1:

El club de Ajedrez de Cornellà, va a organizar los próximos ca peonatos mundiales que se celebrarán en la mencionada localidad. Por ese motivo, queremos realizar una base de datos para llevar toda la gestión relativa a participantes, alojamientos y partidas.
Tenemos que tener encuenta lo siguiente:

En el campeonato participan jugadores y arbritos: de ambos se quiere conocer el número de socio, nombre, dirección, teléfono y campeonatos en los que ha participado (como jugador o como árbitro). De los jugadores además queremos saber que nivel de juego tienen.

Ningún arbrito puede participar en el torneo como jugador.

Los países envían al campeonato un número de jugadores y árbitros, aunque no todos los países envían participantes. Todo jugador y arbitro es enviado por un único pais. Un pais puede representar y ser representado por otro pais.

Cada país se identifica por un nújmero correlativo según su orden alfábetico e interesa conocer además de su nombre, el número de clubes de ajedrez existentes en el mismo.

Cada partida se identifica por un número correlativo (Cod_P), la juegan dos jugadores y la arbitra un arbitro. Interesa registrar las partidas que juega cada jugador y el color (blancas o negras) con el que juega. Ha de tenerse ej cuenta que un árbitro no puede arbitrar a jugadores enviados  por el mismo pais que le ha enviado a él.

Todo participante participa al menos en una pártida.

Tanto jugadores como árbitros se alojan en uno de los hoteles en los que se desarrollan las partidas, se desea conocer en qué hotel y en qué fechas se ha alojado cada uno de los participantes. De cada hotel, se dea conocer el nombre, la dirección y el número de teledono.

El campeonato se desarrolla a lo largo de una serie de jornadas (año, mes , día) y cada partida tiene lugar en una de las jornadas aunque no tengan lugar partidas todas las jornadas.

Cada partida se celebra en una de las salas de las que pueden disponer los hoteles, se desea conocer el número de entradas vendidas en la sala para cada partida. De cada sala, se desea conocer la capacidad y medios de que se dispone ( radio, televión, video ... ) para facilitar la retransmisión de los encuentros. Una sala puede disponer de varios medios distintos.

De cada partida se pretende, se pretende registrar todos los movimientos que la componen, la identificación de movimientos se establece en base a un número de orden dentro de cada partida: para cada movimiento se guardan la jugada ( 5 posiciones y un breve comentario realizado por un experto.

EJERCICIO 2:

La Universidad Politécnica de Valencia dispone de un sistema de ficheros en el que almacena la información sobre los
proyectos financiados que llevan a cabo los grupos de investigación de la universidad. A continuación se
describe la información que contienen los ficheros que tienen que ver solamente con las convocatorias de
ayudas públicas.

El fichero de convocatorias mantiene información sobre las convocatorias de ayudas para la realización de
proyectos de investigación. De éstas se guarda la fecha de publicación, el organismo que la promueve, el
programa en que se enmarca el proyecto, la fecha límite de presentación de solicitudes, el número de la
convocatoria (es único dentro de cada programa), la dirección de la web en donde obtener información sobre
ella y el número del BOE o del DOGV en donde se ha publicado. También se guarda la fecha de resolución,
que es el día en que se ha publicado la lista de solicitudes que han sido aprobadas. De cada organismo se
guarda, en otro fichero, el nombre, la dirección, la población, el código postal y el teléfono.

El fichero de solicitudes almacena los datos de las solicitudes que los grupos de investigación presentan
para las distintas convocatorias de ayudas para proyectos. De cada solicitud se guarda información sobre la
convocatoria a la que corresponde: organismo, programa, número y fecha. Además, se guarda la fecha en
que se ha presentado esta solicitud, el título del proyecto (que será único), el nombre del investigador
principal y su departamento. Cuando se publica la resolución, también se guarda la fecha de ésta y, en caso
de ser aprobada la solicitud, se señala. Otros datos que aparecen en este fichero son: el importe económico
que se solicita para llevar a cabo el proyecto, los nombres de los miembros del grupo de investigación que
van a participar en el proyecto y las horas por semana que cada uno va a dedicar al mismo, que pueden ser
distintas para cada investigador ya que pueden estar participando a la vez en otros proyectos. Además, se
guardan las fechas previstas de inicio y finalización del proyecto, su duración en meses y por último, el
número de entrada que ha dado el registro general a la solicitud.

En la futura base de datos se desea reflejar también los grupos de investigación de la universidad, con su
nombre, el investigador responsable y los investigadores que lo integran. De éstos se conoce el nombre,
departamento y área de conocimiento dentro del departamento. Se considera que un grupo de investigación
pertenece al departamento de su investigador responsable, aunque algunos de sus miembros pueden
pertenecer a otro departamento. De los departamentos también se desea conocer el nombre de su director.


EJERCICIO 3:

Una organización no gubernamental se encarga de enviar ayuda material (medicamentos y alimentos) y
ayuda humanitaria (personal sanitario) a campos de refugiados. Esta organización obtiene sus ingresos de
las cuotas de los socios, de los que se desea conocer los datos personales, la cuenta bancaria en donde se
realizan los cargos anuales, la fecha de pago y el tipo de cuota. En la actualidad hay tres tipos de cuotas,
pudiendo variar en el futuro: mínima (10 euros anuales), media (20 euros anuales) o máxima (30 euros
anuales).

Cada socio pertenece a una de las sedes de la organización, cada una de ellas ubicada en una ciudad
distinta. De las sedes se desea conocer el domicilio y el nombre de su director.
La organización cuenta con dos tipos de voluntarios: los que realizan labores humanitarias (personal
sanitario) y los que realizan labores administrativas (personal administrativo). De los primeros se desea
conocer su profesión (médico, ATS, etc.), su disponibilidad actual (sí/no) y el número de trabajos en los que
ha participado. De todos los voluntarios se desea conocer los datos personales y la sede en la que se
inscribieron.

Cada envío tiene un destino y una fecha de salida. Para identificar los envíos, se les asigna un código
único. Además, cada envío es organizado por una o varias sedes. Los envíos de ayuda material pueden ser
de alimentos, debiéndose conocer el número de toneladas de cada alimento que se manda; o pueden ser de
medicamentos, debiéndose conocer el número de unidades de cada medicamento. De los envíos de ayuda
humanitaria se debe conocer el número de voluntarios que se mandan de cada profesión (por ejemplo: 10
médicos, 20 ATS) y quienes son cada uno de ellos.
