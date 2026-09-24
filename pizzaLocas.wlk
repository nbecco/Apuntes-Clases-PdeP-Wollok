// CLASE 24/09 - Tema: Clases



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

    method leGusta(tipoDePizza) = pizzasFavoritas.contains(tipoDePizza)

    method comprar(tipoDePizza) {
        crazyPizzaPoints += tipoDePizza.costo() / 100
    }

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
}

class Premio {
    const usuario
    const año 

    method textoConmemorativo() = usuario.nombre() + " gano el premio en el año " + año
    method esViejo() = año < 2020

}

object sistemaDeUsuario {
    const usuariosRegistrados = []

    method registrar(nombre) {
        const nuevoUsuario = new Usuario(nombre = nombre)
        usuariosRegistrados.add(nuevoUsuario)
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


// QUEDA TERMINAR EL ULTIMO PUNTO Y REHACER POR MI CUENTA