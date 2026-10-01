// CLASE 24/09 y 01/10 - Tema: Clases, Excepciones, Garbage Collector, Well-Known Objects

// Excepciones: se utilian para CORTAR la ejecucion del codigo y avisar cuando ocurre un caso especifica, similiar al try catchAllErrors
// Ejemplos: else throw new DomainException(message='...') 

// Garbage Collector: se encarga de borrar todos los objetos que no estemos utilizando de la memoria, 
// ya que wollok guarda las cosas que fuimos creando en memoria y cuando las borramos del codigo todavia 
// no se borran de la memoria (creo que es lo que nos pasaba en wollok game)

// Well-Known Objects (WKO): son los objetos que se crean en el codigo (object ...{}), no los que se crean luego de poner new de una clase


// En este caso no es necesario hacer clases porque no hay una repeticion de logica entre las pizzas,
// unicamente se estan seteando sus valores, o sea conviene hacer a las pizzas mediante objetos. Por ej:
// si en realidad el precio de una pizza seria: "precio() = 20 * valor base", ahi si que habria repeticion 
// de logica y por ende deberiamos usar clases.
class Pizzas {
    var precio
    var vegetariana
}

object pizzaMuzza {
    method precio() = 20000
    method esVegetariana() = true
}
object pizzaNapolitana {
    method precio() = 24000
    method esVegetariana() = true
}
object pizzaMuzzaConPepperoni {
    method precio() = 24000
    method esVegetariana() = false
}
object pizzaJamonYMorron {
    method precio() = 26000
    method esVegetariana() = false
}

class Usuario {
    const pizzasFavoritas = []
    var nombre
    var crazyPizzaPoints = 0
    const premios = []


    method agregarPizzasFavoritas(nuevaPizza) {
        pizzasFavoritas.add(nuevaPizza)
    }

    method pizzasFavoritas() =pizzasFavoritas

    method leGusta(tipoDePizza) = pizzasFavoritas.contains(tipoDePizza)

    method comprar(tipoDePizza) {
        if( sistemaDeUsuario.estaRegistrado(self) ){
            crazyPizzaPoints += tipoDePizza.costo() / 100
            pizzeria.ejecutarVenta(tipoDePizza)
        }
        else {
        throw new DomainException(message='El usuario no esta registrado')
        }
    }   

    method points() = crazyPizzaPoints

    method sumarPuntos(cantidad) {
        crazyPizzaPoints += cantidad
    }

    method nombre() = nombre

    method esPizzaAficionado() = crazyPizzaPoints > 1000

    method obtenerPremio() {
        const añoActual = new Date().year()
        const nuevoPremio = new Premio(usuario = self, año = añoActual)
        premios.add(nuevoPremio)
    }

    method premios() = premios
}

class Premio {
    const usuario
    const año 

    method textoConmemorativo() = usuario.nombre() + " gano el premio pizza loca en el año " + año
    method esViejo() = año < 2020

}

object sistemaDeUsuario {
    const usuariosRegistrados = []

    method registrar(nombre) {
        const nuevoUsuario = new Usuario(nombre = nombre)
        usuariosRegistrados.add(nuevoUsuario)
    }

    method estaRegistrado() = 

    method agregarUsuarioYaExisitente() {

    }

    method aCuantosLesGusta(tipoDePizza) = 
        usuariosRegistrados.filter({usuario => usuario.leGusta(tipoDePizza)}).size()

    method sumarCrazyPoints() {
        usuariosRegistrados.forEach({ usuario => usuario.sumarPuntos(100)})
    }

    method nombresDeUsuarios() = usuariosRegistrados.map({ usuario => usuario.nombre() })

    method darPremios() {
        const aficionados = usuariosRegistrados.filter({ usuario => usuario.esPizzaAficionado() })
        aficionados.forEach({ aficionado => aficionado.obtenerPremio() })
    }
}

object pizzeria {
    var ganacia = 0

    method ganacias() = ganacia

    method ejecutarVenta(pizza){
        ganacia += pizza.precio()
    }
}


//QUE COSAS ME FALTAN:
// agregarUsuarioYaExisitente en object sistemaDeUsuario
// estaRegistrado en object sistemaDeUsuario y en el method comprar del object usuario