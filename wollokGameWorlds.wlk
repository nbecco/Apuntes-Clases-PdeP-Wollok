object partida {
    var participanteAzul = null
    var participanteRojo = null
    var yaSeJugo = false


    method jugar() {
        participanteAzul.jugar()
        participanteRojo.jugar()
        yaSeJugo = true
    }

    method quienGano(){
        if(!yaSeJugo){
            throw new DomainException(message='No se puede preguntar ya que la partida no se jugo!')
        } 

        if(participanteAzul.habilidad() > participanteRojo.habilidad()) participanteAzul else participanteRojo
    }
}

class Jugador {
    var property antiguedad
    var property nivelDeCansancio = 50


    method esTitular() = antiguedad > 3
    
    method totalmenteCansado() = nivelDeCansancio > 100

    method beberEnergizante() {
        nivelDeCansancio = 0.max(nivelDeCansancio - 10)
    }

    method habilidad() = antiguedad * 2 - nivelDeCansancio

    method puedeJugar() = self.esTitular() and !self.totalmenteCansado()

    method jugar() {
        if( self.puedeJugar() ){
            nivelDeCansancio += 20
        } else {
            throw new DomainException(message='El jugador no esta en condiciones de jugar!')
        }
    }
}

const caps = new Jugador(antiguedad = 5)
const josedeodo = new Jugador(antiguedad = 1)

object faker {
    var property habilidadAcumulada = 0
    var estaTilteado = false

    method habilidad() {
        if( estaTilteado ){
            return 0
        } else {
                    return habilidadAcumulada
        }
    }

    method jugar() {
        habilidadAcumulada += 20
    }

    method tomarTecito() {
        estaTilteado = false
    }
}

  
class Equipo {
    const integrantes = []

    method habilidad() = integrantes.sum( { jugador => jugador.habilidad()}  )

    method jugar() {
        integrantes.forEach({ jugador => jugador.jugar() })
    }

    method agregarJugador(unJugador) {
        integrantes.add(unJugador)
    }
}

// FALTAN LOS TEST DE ESTE EJERCICIO