// CLASE 29/10: "SIMULACRO DE PARCIAL"

// !!! FALTA COPIAR EL CODIGO DEL PROFE PORQUE ESTE ESTA MUY INCOMPLETO

object pdepefoni {
    method precioMes(cantMb) {
        consumo = 2 * cantMb
    }

    method precioFijoLlamada(cantSegundos) {
        if( cantSegundos > 30 ) consumo = 100 + 10 * (cantSegundos - 30)
        else  consumo = 100
    }
}

class Cliente {
    const numeroTelefono
    const packsActivos = []
    const consumosHistoricos = []


    method comprarPack(paquete) {
        packsActivos.add(paquete)
    }

    method costoPromedio(fechaInicial, fechaFinal) {
        const consumosEnFecha = consumosHistoricos.filter({ consumo => consumo.estaEnRango(fechaInicial, fechaFinal)})

        return consumosEnFecha.sum({ consumo => consumo.costo() }) / consumosEnFecha.size()
    }

    method costoTotalMensual() {
        const hoy = new Date()
        const haceUnMes = new Date().minusDay(30)

        return self.costoPromedio(haceUnMes, hoy)
    }

    method puedeConsumir(consumo) = packsActivos.any({ pack => pack.puedeSatisfacerConsumo(consumo)})

    // metodo limpiarPacks con filter forEach y remove
    method limpiarPacks() {
        const paquetesALimpiar = packsActivos.filter({ pack => pack.tieneQueSerLimpiado() })

        paquetesALimpiar.forEach({ pack => self.limpiarPack(pack)})
    }
    method limpiarPack(pack) {
        packsActivos.remove(pack)
    }

    // metodo limpiarPacks con 
    method limpiarPacks2
}


class Consumo {
    const fecha = new Date()

    method costo()

    method estaEnRango(fechaInicial, fechaFinal) = fecha.between(fechaInicial, fechaFinal)

    method esDelLlamada() = false
    method esDelInternet() = false
}

class ConsumoDeInternet inherits Consumo {
    const mbs

    override method costo() = pdepefoni.precioMes() * mbs

    override method esDelInternet() = true
}
class ConsumoDeLlamada inherits Consumo {
    const duracion

    override method costo() = pedepefoni.precioFijoLlamada() + duracion 

    override method esDelLlamada() = true

}


class Pack {
    method tieneQueSerLimpiado()
    method puedeSatisfacerConsumo(consumo)
}

class packDeCreditos {
    var creditos 

    method tieneQueSerLimpiado()
    method puedeSatisfacerConsumo(consumo) = creditos > consumo.costo()
}

class packMbsLibres {
    const mbsLibres

    method tieneQueSerLimpiado()
    method puedeSatisfacerConsumo(consumo) = consumo.loSatisfaceConInternet()
}

class LlamadasGratis {
    method tieneQueSerLimpiado()
    method puedeSatisfacerConsumo(consumo) = consumo.esDelLlamada()
}

class InternetIlimitado {
    method tieneQueSerLimpiado()
    method puedeSatisfacerConsumo(consumo) = consumo.esDelInternet() && self.esFinde()

    method esFinde() = (...)
}