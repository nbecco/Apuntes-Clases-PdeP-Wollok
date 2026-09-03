// PRIMERA CLASE (20/08)

object homero {
  var donas = 0

  // Compra por docena, le pasamos cuántas docenas compra
  method comprar(docenas) {
    donas = donas + (docenas * 12)
  }

  // Come de a una, restamos 1 al estado
  method comer() {
    donas = donas - 1
  }

  // No necesita parámetro, consulta su propia variable
  method estaDistraido() {
    return donas < 2
  }
}


object plantaNuclear {
  var barrasUranio = 0
  var encargado = homero // Conectamos a Homero como el encargado

  //Para poder cambiar el encargado a Lenny
  method cambiarEncargado(nuevoEncargado) {
    encargado = nuevoEncargado
  }

  // Llega un cargamento y se suma al depósito
  method recibirCargamento(cantidad) {
    barrasUranio = barrasUranio + cantidad
  }

  // Chequea las barras y le pregunta al encargado si está distraído
  method estaEnPeligro() {
    return barrasUranio > 10000 && encargado.estaDistraido() 
  }

  // Este es del punto de Mr Burns, pero en realidad se deberia modificar el method estaEnPeligro y quedaria solo este
  method estaEnPeligro2() {
    const peligroPorDistraccion = barrasUranio > 10000 && encargado.estaDistraido()
    
    return peligroPorDistraccion || mrBurns.esPobre()
  }

}


object patoBalacin {
  method estaDistraido() = false // Nunca se distrae
}

object lenny {
  var cervezasTomadas = 0

  method tomarCerveza(){
    cervezasTomadas = cervezasTomadas + 1
  }

  method estaDistraido(){
    return cervezasTomadas > 3
  }
}


object mrBurns {
  var esMillonario = true

  method esPobre(){
    return not esMillonario
  }

  method despojarRiquezas(){
    esMillonario = false
  }

}