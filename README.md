# WeatherApp
Prueba tecnica para la empresa Bold

esta fue realizara usando Swift 5+, metaweather API y se implemento VIPER como patron de diseño
Esta aplicacion permite buscar una ciudad o un pais y ver el clima del mismo. asi como guardar en favorito el de su agrado.

# Consideraciones
para la realizacion de esta aplicacion, logre enfocarme en los puntos importantes del desarrollo, dejando un poco de lado la parte de diseño de la misma, por lo que el diseño de la app, quizas no sea el mas agradable.  

# Descripción 
La aplicación esta divida por diferentes capas, que son:

**- Capa de persistencia:** Esta capa esta encargada de manejar el almacenamiento local de la información, en este proyecto utilice  CoreData como base de datos nativa de swift, la capa de persistencia esta manejada dentro del archivo APICoreDataService, en el que están los diferentes métodos utilizados en la aplicación para guardar y leer los datos locales haciendo uso de una instancia compartida (singleton).

**- Capa de red:** Esta capa es la encargada de manejar todas las peticiones de red, en este proyecto utilice la implementación nativa de Swift ( URLSession ), esta capa esta manejada dentro del archivo BaseServices el cual solo tiene el metodo .GET ,ya que fue el único necesario para la realización de este proyecto. Esta clase tiene una única función estática y y lo que hago es que en las clases de los servicios heredan de BaseServices para poder utilizar este método.

**- Capa de vistas:** Las vistas son las encargadas  de mostrar la informacion por pantalla. En este proyecto haciendo uso del patron de arquitectura VIPER lo que hago es modularizar las pantallas del proyecto. La capa de vista esta comprendida entre el uso de las vistas y los presenters que son los encargados de enviar la informacion ya preparada y lista para ser mostrada en los diferentes ViewControllers.

**- Capa de negocio:** Esta capa tiene la responsabilidad de manejar todo lo que es la lógica del negocio valga la redundancia, haciendo uso de los interactors, ya que son los encargados de establecer la comunicación con los servicios. Los interactors son los responsables de recibir las respuestas de las llamadas al servidor, para así limpiar los datos en caso de ser necesario y enviarle la información lista al presenter, y evitar que maneje lógica de ese lado ya que no es su responsabilidad.

**- Capa de navegación:** Esta capa  tiene la responsabilidad de establecer la comunicación entre las diferentes pantallas o modelos del proyecto.

**- Capa de datos:** Esta capa conforma los diferentes modelos utlizados.

# Responsabilidad de algunas de las clases creadas en el proyecto. 

**APICoreDataService**: Es la clase encargada manejar los datos de CoreData.

**BaseServices**: Es la clase encargada de manejar las peticiones de red de la aplicacion.

**ListScreenService, DetailListService**: Son las clases encargadas de la comunicación entre el interactor y las peticiones de red de sus respectivas vistas.

**ListScreenViewController, DetailListViewController**: son las clases encargadas de mostrar las informacion en pantalla de cada una de sus respectivas vistas.

**ListScreenInteractor, DetailListInteractor**: son las clases encargadas de comunicarse con los servicios web y devolver los datos a sus respectivos presenters. 

**ListScreenPresenter, DetailListPresenter**: son las clases encargadas de la comunicacion entre sus respectivos interactor y las vistas. 

**ListScreenRouter:** es la clase encargada de la navegacion entre las vistas en la aplicacion, su invocacion depende directamente del presenter. 
