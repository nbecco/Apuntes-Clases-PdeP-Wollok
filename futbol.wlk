// SEGUNDA CLASE (03/09)

// CONCEPTOS IMPORTANTES:
// - Acoplamiento = cuando un objeto depende de otro, si uno cambia el otro se ve afectado
// - Reificacion = cuando un objeto depende de otro, pero no se ve afectado si el otro cambia
// - guardar vs calcular = cuando un objeto guarda un valor que depende de otro, si el otro cambia el primero se ve afectado. Cuando un objeto calcula un valor que depende de otro, si el otro cambia el primero no se ve afectado (siempre va a ser mejor guardar que calcular)
// - interfaz = es todo lo que tiene que entender un objeto para ser reconocido como tal (por ejemplo un equipo es reconocido como un equipo si tiene goles, hinchada, dinero y capacidadOfensiva, si le agregamos otra cosa no deja de ser un equipo, pero si le sacamos una de esas cosas deja de ser un equipo, ya que todos estos parametros/argumentos son utilizados entre si para calcular quien gana)
// - polimorfismo = para que un objeto sea polimorfo a otros debe cumplir con su interfaz, es decir, debe tener los mismos métodos que los otros objetos. Por ejemplo, si un objeto tiene goles, hinchada, dinero y capacidadOfensiva, es polimorfo a los equipos. Si le agregamos otra cosa no deja de ser polimorfo, pero si le sacamos una de esas cosas deja de ser polimorfo. El polimorfismo es importante porque nos permite hacer que un objeto pueda ser utilizado en lugar de otro (por ejemplo, podemos hacer que un objeto sea utilizado en lugar de un equipo si cumple con la interfaz de equipo). Esto nos permite hacer que nuestro código sea más flexible y reutilizable.

object river {
    var dineroEnCaja = 1000000
    const cantidadDeSocios = 100
    method goles(rival) = (self.dinero() - rival.dinero()).div(1000000)

    method dinero() = ((dineroEnCaja + cantidadDeSocios) * 13000)

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

    method cantidadDeHinchas() = 10000 + cantidadDeSocios * 2

    method capacidadOfensiva() = self.dinero().div(1000000)
}

object lali {
    method recaudacion() = 5000000
}

object mana {
    method recaudacion() = 3500000
}

object karolG {
    method recaudacion() = lali.recaudacion() // Karol G recauda lo mismo que Lali
}



object barracas {
    method hinchada() = 800
    method dinero() = 1000000
    method capacidadOfensiva() = 5
    method goles(rival) = rival.goles(self) + 1
}


// FALTA TERMINAR EL OBJETO DE BOCA
object boca {
    var golesMarcados = 1
    method goles(rival) = 1 + ( self.capacidadOfensiva()- rival.capacidadOfensiva() / 3)
    method hinchas() = 54000

    method dinero() = self.ingresos(jugador) - self.deudas()

    method ingresos(jugador) {
        return jugador.valor()
    }

    method deudas() {
        return 1000000
    }

    method capacidadOfensiva() {
        if(self.deudas() > self.ingresos(jugador) *2 ) {
            return 25
        } else {
            return 40
        }
    }
}

object cachoPanceta {
    method valor() = 1000000
}
object francoFranco {
    method valor() = 2000000
}


// FALTA HACER EL OBJETO DE VELEZ
object velez {

}


// FALTA TERMINAR EL REFEREE (LO DE PENALES Y NO SE SI ALGO MAS)
object referee {
    method quienGanaEntre(equipo1, equipo2) {
        if (equipo1.goles(equipo2) > equipo2.goles(equipo1)) {
            return equipo1
        } else if (equipo2.goles(equipo1) > equipo1.goles(equipo2)) {
            return equipo2
        } else {
            return null // Empate
        }
    }
}