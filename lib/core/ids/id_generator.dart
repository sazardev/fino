/// Produce un identificador único cada vez que se invoca.
///
/// Se inyecta en los casos de uso para que el dominio sea determinista en
/// pruebas y no dependa de ningún SDK.
typedef IdGenerator = String Function();
