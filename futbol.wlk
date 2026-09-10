// SEGUNDA CLASE (03/09) y TERCERA CLASE (10/09)

// CONCEPTOS IMPORTANTES:
// - Acoplamiento = cuando un objeto depende de otro, si uno cambia el otro se ve afectado

// - Reificacion = cuando un objeto depende de otro, pero no se ve afectado si el otro cambia

// - guardar vs calcular = cuando un objeto guarda un valor que depende de otro, si el otro cambia el 
//   primero se ve afectado. Cuando un objeto calcula un valor que depende de otro, si el otro cambia 
//   el primero no se ve afectado (siempre va a ser mejor guardar que calcular)

// - interfaz = es todo lo que tiene que entender un objeto para ser reconocido como tal (por ejemplo 
//   un equipo es reconocido como un equipo si tiene goles, hinchada, dinero y capacidadOfensiva, si le
//   agregamos otra cosa no deja de ser un equipo, pero si le sacamos una de esas cosas deja de ser un
//   equipo, ya que todos estos parametros/argumentos son utilizados entre si para calcular quien gana)

// - polimorfismo = para que un objeto sea polimorfo a otros debe cumplir con su interfaz, es decir, 
//   debe tener los mismos métodos que los otros objetos. Por ejemplo, si un objeto tiene goles, hinchada,
//   dinero y capacidadOfensiva, es polimorfo a los equipos. Si le agregamos otra cosa no deja de ser 
//   polimorfo, pero si le sacamos una de esas cosas deja de ser polimorfo. El polimorfismo es importante 
//   porque nos permite hacer que un objeto pueda ser utilizado en lugar de otro (por ejemplo, podemos
//   hacer que un objeto sea utilizado en lugar de un equipo si cumple con la interfaz de equipo). Esto
//   nos permite hacer que nuestro código sea más flexible y reutilizable.

// - consulta vs. efecto = una consulta es un método que no cambia el estado del objeto, mientras que 
//   un efecto es un método que cambia el estado del objeto. Por ejemplo, el método goles es una consulta,
//   mientras que el método hacerConcierto es un efecto. Es importante tener en cuenta esto porque las 
//   consultas son más fáciles de razonar y probar, mientras que los efectos pueden tener efectos 
//   secundarios inesperados. Un ejemplo en listas: sum es consulta y add o remove son efecto.

// - getter vs. setter = un getter es un método que devuelve un valor de un objeto, mientras que un 
//   setter es un método que cambia un valor de un objeto. Por ejemplo, el método goles es un getter,
//   mientras que el método hacerConcierto es un setter. Es importante tener en cuenta esto porque los 
//   getters son más fáciles de razonar y probar, mientras que los setters pueden tener efectos secundarios
//   inesperados. Un ejemplo en listas: size es getter y add o remove son setter.

// - property = es un atajo que se usa al declarar un atributo para indicarle al lenguaje que genere 
//   los getters y setters automáticamente por detrás, sin que tengas que escribirlos a mano. Por ejemplo:
// object jugador {
//     property valor = 1000000
// }
// object jugador {
//     var valor = 1000000

//     // Getter generado automáticamente
//     method valor() = valor 

//     // Setter generado automáticamente
//     method valor(nuevoValor) {
//         valor = nuevoValor
//     }
// }



// FUNCIONES DE LISTAS:
// - sum() = suma todos los elementos de la lista
// - size() = devuelve la cantidad de elementos de la lista
// - remove() = elimina un elemento de la lista
// - add() = agrega un elemento a la lista
// - anyOne() = devuelve un elemento aleatorio de la lista



// CLOSURES: son funciones que se pueden pasar como parámetro a otros métodos. Por ejemplo, en el método map, filter, forEach y count, se pasa una función entre llaves { } como parámetro que se aplica a cada elemento de la lista. Esto nos permite hacer que nuestro código sea más flexible y reutilizable, ya que podemos pasar diferentes funciones como parámetro para obtener diferentes resultados.

// - map = es un método que se aplica a una lista y devuelve una nueva lista con los resultados de aplicar una función a cada elemento de la lista.
//   Ej de map: 
//   method dinero() = ingresos.map({ ingreso => ingreso.valor() }).sum()

// - filter = es un método que se aplica a una lista y devuelve una nueva lista con los elementos que cumplen con una condición. 
//   O sea es una consulta no un efecto, ya que no modifica la lista original, sino que devuelve una nueva lista con los elementos que cumplen con la condición.
//   Ej de filter:
//   method ingresosMayoresA1000() = ingresos.filter({ ingreso => ingreso.valor() > 1000 })

// - forEach = es un método que se aplica a una lista y ejecuta una función para cada elemento de la lista. 
//   Es un efecto, ya que puede modificar el estado del objeto. O sea, no devuelve nada, sino que ejecuta una función para cada elemento de la lista.
//   Ej de forEach:
//   method mostrarIngresos() {
//     ingresos.forEach({ ingreso => console.println(ingreso.valor()) })
//   }

// - count = es un método que se aplica a una lista y devuelve la cantidad de elementos que cumplen 
//   con una condición. Es la fusion de filter y size, ya que primero filtra los elementos que cumplen 
//   con la condición y luego devuelve la cantidad de elementos de la lista filtrada.
//   Ej de count:
//   method cantidadDeIngresosMayoresA1000() = ingresos.count({ ingreso => ingreso.valor() > 1000 })

// RIVER
object river {
    var dineroEnCaja = 1000000
    const cantidadDeSocios = 100
    method goles(rival) = ((self.dinero() - rival.dinero()) / 1000000).roundUp()

    method dinero() = (dineroEnCaja + (cantidadDeSocios * 13000))

    // LO PENSAMOS ASI Y LOS PROFES NOS DIJERON QUE NO ES LO CORRECTO
    // method concierto(cantante) {
    //     if(cantante == "Lali" || cantante == "Karol G")
    //         dineroEnCaja = dineroEnCaja + 5000000
    //     else if(cantante == "Mana")
    //         dineroEnCaja = dineroEnCaja + 3500000
    // }

    method hacerConcierto(concierto) {
        dineroEnCaja += concierto.recaudacion()
    }

    method hinchas() = 10000 + cantidadDeSocios * 2

    method capacidadOfensiva() = self.dinero().div(1000000)
}
// CONCIERTOS DE RIVER
object lali { method recaudacion() = 5000000 }
object mana { method recaudacion() = 3500000 }
object karolG { method recaudacion() = lali.recaudacion() } // Karol G recauda lo mismo que Lali



// BARRACAS
object barracas {
    method hinchas() = 800
    method dinero() = 1000000
    method capacidadOfensiva() = 5
    method goles(rival) = rival.goles(self) + 1
}



// BOCA
object boca {
    const ingresos = []
    const deudas = []
    
    method goles(rival) = 1 + (self.capacidadOfensiva() - rival.capacidadOfensiva()).div(3)
    method hinchas() = 54000

    method dinero() = self.sumatoriaDeIngresos() - self.sumatoriaDeDeudas()

    method sumatoriaDeIngresos() = ingresos.sum() 
    method sumatoriaDeDeudas() = deudas.sum()
    
    method vender(jugador) {
        ingresos.add(jugador.valor())
    }

    method agregarDeuda(monto) {
        deudas.add(monto)
    }

    method estaEnMalMomento() = deudas.size() > (ingresos.size() * 2)
    
    method capacidadOfensiva() {
        if(self.estaEnMalMomento()) {
            return 25
        } else {
            return 40
        }
    }
}
// JUGADORES DE BOCA
object cachoPanceta { method valor() = 1000000 }
object francoFranco { method valor() = 2000000 }



// VELEZ
object velez {
    var jugadorFigura = perroGutierrez

    method goles(rival){
        if( self.capacidadOfensiva() > rival.capacidadOfensiva() ){
            return 3
        } else {
            return 1
        }
    }
    method dinero() = jugadorFigura.valor()

    method capacidadOfensiva() = jugadorFigura.habilidad() * 4

    method hinchas() = jugadorFigura.habilidad() * 2000

    method cambioDeJugadorFigura(jugador) {
        jugadorFigura = jugador
    }
}
// JUGADOR FIGURA DE VELEZ
object perroGutierrez {
    method valor() = 1000000
    method habilidad() = 100
}



// REFEREE
object referee {
    method quienGanaEntre(equipo1, equipo2) {
        if (equipo1.goles(equipo2) > equipo2.goles(equipo1)) {
            return equipo1
        } else if (equipo2.goles(equipo1) > equipo1.goles(equipo2)) {
            return equipo2
        } else {
            return [equipo1, equipo2].anyOne()
        }
    }
}