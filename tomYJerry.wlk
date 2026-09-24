object casa {
    var property cuidador = tom  
    var property quilombero = null
    var property suciedad = 0

    method pasaElDia() {
        cuidador.limpiar(self)
        if(quilombero!=null && cuidador.puedeAtraparlo(quilombero)){
            quilombero = null
        }
    }
    method pasaLaNoche() {
        cuidador.dormir()
        if(quilombero!=null){
            quilombero.hacerQuilombo(self)
        }
    }   


    method limpiar(nuevaSuciedad) {
        suciedad = suciedad - nuevaSuciedad
    }
    method ensuciar(nuevaSuciedad) {
        suciedad = suciedad + nuevaSuciedad
    }
    method limpiarCompletamente() {
        suciedad = 0
    }
}

object tom {
    var energia = 0
    
    method limpiar(casa){
        casa.limpiar(100)
        energia = energia - 40
    }

    method velocidad() = 5 + (energia / 10)

    method puedeAtraparlo(unQuilombero) = self.velocidad() > unQuilombero.velocidad()

    method dormir() {
        energia = energia + 50
    } 

    method interrumpirSueño() {
        energia -= 20
    }
}

object jerry {
    var peso = 0

    method hacerQuilombo(casa) {
        casa.ensuciar(110)
        peso += 1
    }

    method velocidad() = 10 - peso
}

object tuffy {
    method velocidad() = 10

    method hacerQuilombo(casa) {
        casa.cuidador().interrumpirSueño()
    }
}

object robocat {
    method limpiar(casa) {
        casa.limpiarCompletamente()
    }

    method puedeAtraparlo(unQuilombero) = true

    method dormir() {
        //Se Apaga
    }

    method interrumpirSueño() {
        //No le pueden hacer nada
    }
}

object pandilla {
    const property miembros = [jerry, tuffy] 

    method hacerQuilombo(casa) {
        miembros.forEach( { miembro => miembro.hacerQuilombo(casa) } )
        if(miembros.size() > 3){
            casa.cuidador().interrumpirSueño()
        }
    }

    method velocidad() = miembros.map( { miembro => miembro.velocidad() } ).min() / 2
}


// NUEVO CUIDADOR
object sofia {
    var energia = 10

    method limpiar(casa) {
        casa.limpiar(10000000)
    }

    method velocidad() = 1

    //method puedeAtraparlo(unQuilombero) = unQuilombero == nicolas

    method dormir() {
        energia += 9000
    }

    method interrumpirSueño() {
        energia -= 100
    }
}


// NUEVO QUILOMBERO
object nicolas {
    const peso = 65

    method hacerQuilombo(casa) {
        casa.ensuciar(1)
        //SIEMPRE INTERRUPE EL SUEÑO DE SOFIA A SOFIA INDEPENDIENTEMENTE DE QUIEN SEA EL CUIDADOR
        sofia.interrumpirSueño()
    }

    method velocidad() = peso * 10
}


// FALTA PUNTO TEORICO POR MI CUENTA

// FALTA TESTS POR MI CUENTA