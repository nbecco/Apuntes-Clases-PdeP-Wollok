object departamentoDeLaMuerte {
    const agentes = []
    const paquetesPredefinidos = []

    method mejorAgente() = agentes.max({ agente => agente.getCantidadPaquetesVendido() })

    method diaDeMuertos() {
        self.mejorAgente().setDeuda(-50)
        agentes.removeAll(agentes.filter({ agente => agente.getDeuda() <= 0 }))
        agentes.filter({ agente => agente.getDeuda() >= 0 }).forEach({ agente => agente.setDeuda(+100) })
    }

    method getPaquetesPredefinidos() = paquetesPredefinidos

    method agregarAgente(agente) {
        agentes.add(agente)
    }
}

class Agente {
    var deuda
    const montosVendidos  = []
    var estrategia

    method venderPaquete(paquete, alma) {
        if( !alma.puedeCostear(paquete) ){
            throw new DomainException(message = "El alma no puede costear el paquete")
        }
        deuda = deuda - paquete.costoPara(alma)
        montosVendidos.add(paquete.costoPara(alma))
    }


    method getCantidadPaquetesVendido() = montosVendidos .size()

    method getDineroTotalVentas() = montosVendidos.sum()

    method getDeuda() = deuda
    method setDeuda(nuevaDeuda) {
        deuda += nuevaDeuda
    }

    method cambiarEstrategia(nuevaEstrategia) {
        estrategia = nuevaEstrategia
    }

    method atender(alma) {
        self.venderPaquete(estrategia.paquetePara(alma),alma)
    }
}

object estrategiaClasica {
    method paquetePara(alma) = departamentoDeLaMuerte.getPaquetesPredefinidos().filter({ paquete => alma.puedeCostear(paquete) }).max({ paquete => paquete.costoPara(alma) })
}
object estrategiaNavegante {
    method paquetePara(alma) =
        if( alma.getAccionesBuenas() >= 50 ) {
            new PaqueteCrucero(basico = alma.getAccionesBuenas())
        } else {
            new PaqueteBote(basico = alma.getAccionesBuenas())
        }
}
object estrategiaIndiferente {
    method paquetePara(alma) = new PaquetePaloConBrujula(basico = 1.randomUpTo(300))
    
}

class Alma {
    const dineroAlMorir
    const accionesBuenas


    method capital() = dineroAlMorir + accionesBuenas

    method puedeCostear(paquete) = self.capital() >= paquete.costoPara(self)

    method getAccionesBuenas() = accionesBuenas
}

class Paquete {
    const basico

    method costoPara(alma) = (basico * self.aniosQueReduce(alma)).min(350)

    method aniosQueReduce(alma)
}

class PaqueteTren inherits Paquete {
    override method aniosQueReduce(alma) = 4
}
class PaqueteBote inherits Paquete {
    override method aniosQueReduce(alma) = (alma.getAccionesBuenas() / 50).min(2)
}
class PaqueteCrucero inherits PaqueteBote {
    override method aniosQueReduce(alma) = super(alma) * 2
}
class PaquetePaloConBrujula inherits Paquete {
    override method aniosQueReduce(alma) = 0.05

    override method costoPara(alma) = basico
}
