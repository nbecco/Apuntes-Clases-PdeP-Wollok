object simulador {
    method ganadorDelPartido(local, visitante) {
        if( local.goles(visitante) > visitante.goles(local) ){
            local
        } 
        else if( visitante.goles(local) > local.goles(visitante) ){
            visitante
        }
        else{
            [local, visitante].anyOne()
        }
    }
}

object river {
    var dineroEnCaja = 1000000
    const socios = 100000 // LO PUSE COMO VARIABLE PORQUE NUNCA ESPECIFICA COMO SE CALCULA

    method goles(rival) = ( ( self.dinero() - rival.dinero() ) / 1000000).roundUp()

    method dinero() = dineroEnCaja + (socios * 13000)

    method ganarDineroEnCaja(recital){
        dineroEnCaja += recital.costo()
    }

    method cantidadHinchas() = 10000 + socios * 2

    method capacidadOfensiva() = self.dinero() / 1000000
}
object lali { method costo() = 5000000 }
object mana { method costo() = 3500000 }
object karolg { method costo() = lali.costo() }



object boca {
    const ingresos = []
    const deudas = []

    method goles(rival) = 1 + ( (self.capacidadOfensiva() - rival.capacidadOfensiva()) / 3 ).roundDown()

    method dinero() = ingresos.sum() - deudas.sum()

    method venderJugador(jugador) {
        ingresos.add(jugador.precio())
    }

    method agregarDeuda(monto) {
        deudas.add(monto)
    }

    method cantidadHinchas() = 54000

    method capacidadOfensiva() {
        if(self.estaEnMalMomento()) {
            return 25
        } else {
            return 40
        }
    }

    method estaEnMalMomento() = deudas.size() > ingresos.size() * 2
}
object cachoPanceta { method precio() = 1000 }
object francoFranco { method precio() = 2000 }



object velez {
    const jugadores = []

    method goles(rival) = if(self.capacidadOfensiva() > rival.capacidadOfensiva()) 3 else 1

    method jugadorFigura() = jugadores.first()

    method dinero() = jugadores.map({ jugador => jugador.precio() }).sum()
    //una mejor forma:                jugadores.sum({ jugador => jugador.precio() })

    method capacidadOfensiva() = jugadores.filter( { jugador => jugador.habilidad().even() } ).size()
    //una mejor forma:           jugadores.count({ jugador => jugador.habilidad().even() })

    method cantidadHinchas() =  self.jugadorFigura().habilidad() * 2000

    method diaDePracticas() {
        jugadores.forEach({ jugador => jugador.entrenar() })
    }
}
object ejemploJugadorDeVelez {
    method precio() = 1000
    method habilidad() = 8
    method entrenar() { }
}



object barracas {
    method goles(rival) = rival.goles(self) + 1

    method cantidadHinchas() = 800

    method capacidadOfensiva() = 5

    method dinero() = 1000000
}

