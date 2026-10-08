/*
APUNTES CLASE 08/10 "HERENCIA":

TABLA PARA LOS DIAGRAMAS
_________________
|Nombre clase/obj|
|________________|
|   Variables    |
|________________|
|    Metodos     |
|________________|
* Obs: Estos cuadros se conectan entre los otros cuadros que haya con los distintos tipos de flecha.

FLECHAS PARA LOS DIAGRAMAS:
1) _______________▶ : "Tiene" / "Conoce a"
2) - - - - - - - -▶ : "Usa a"
3) - - - - - - - -▷ : "Implementa a"
4) _______________▷ : "Hereda de" / "Es un"


- Herencia: es para evitar la repeticion de logica entre las clases. Existe las "Superclases",
  que son las principales y las "Subclases" que adquieren el comportamiento de las Superclases 
  y cambian pequeñas cosas.

- Override: sirve para redefinir un comportamiento de un method. O sea si en una Superclase utilizo 
  un metodo de una forma, y en una Subclase quiero utilizar ese mismo metodo pero cambiado, ahi utilizo
  el override.

- Super(): es como el "self", solo que en vez de buscarse a si mismo, busca a la Superclase. Solo se 
  puede utilizar super cuando estamos en un metodo con override.
  trampa del super -> Self y Super siempre hacen la accion en si mismo (o sea donde se instancia), 
  la diferencia es donde arranca a buscar el mensaje

- method look up: es el mecanismo que usa Wollok para decidir qué código (qué método) se debe
  ejecutar cuando le envías un mensaje a un objeto

 "Wollok es un lenguaje de herencia simple, o sea solo se puede heredar una vez por clase".

- method concreto vs abstracto: el metodo concreto es el que tiene codigo {...}, en cambio el abstracto
  no tiene comportamiento "method name()".

*/

class Estudiante {
    var felicidad
    const varitas = []

    method lanzarHechizo(nube) {
        const varita = self.elegirVarita()
        varita.hechiza(nube)
    }

    method elegirVarita() = varitas.max({ varita => varita.potencia() })

    method restarFelicidad(cantidad) {
        felicidad = 0.max(felicidad - cantidad)
    }
}

class NubeGris {
    var tristeza

    method entristecer(estudiante) {
        estudiante.restarFelicidad(tristeza)
    }

    method estaDespejada() = tristeza == 0

    method perderTristeza(cantidad) {
        tristeza = 0.max(tristeza - cantidad)
    }
}

class NubeTormenta inherits NubeGris {
    var resistencia

    override method perderTristeza(cantidad) {
        const cantidadFinal = cantidad - resistencia
        super(cantidadFinal)
    }
}

class Varita {
    var brillo
    
    method potencia()

    method puedeLanzar() = brillo > 0

    method hechiza(nube) {
        if(not self.puedeLanzar()){
            throw new DomainException(message="No se puede hechizar con una varita con brillo en cero")
        }
        nube.perderTristeza(self.potencia())
        if( brillo > 80 ) {
            self.aplicarEfecto(nube)
        }
        self.perderBrillo()
    }

    method desgaste() = 20
    method perderBrillo() {
        brillo = 0.max(brillo - self.desgaste())
    }

    method aplicarEfecto(nube) 
}

class VaritaJugete inherits Varita {
    override method potencia() = 50
    override method desgaste() = 0
    override method aplicarEfecto(nube) { /* nada */ }
}

class VaritaEstrella inherits Varita {
    override method potencia() = 100 - brillo
    override method aplicarEfecto(nube) {
        brillo *= 2
    }
}

class VaritaCorazon inherits Varita {
    const amor
    override method potencia() = amor * 2
    override method puedeLanzar() = true
    override method aplicarEfecto(nube) {
        if(amor > 50) nube.perderTristeza(1000)
    }
}