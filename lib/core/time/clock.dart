/// La hora actual. Se inyecta para que lo que depende del tiempo (reintentos,
/// límites de frecuencia, fechas de registro) sea determinista en pruebas.
typedef Clock = DateTime Function();
