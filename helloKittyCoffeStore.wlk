/*
CLASE 22/10: Herencia vs. Composicion

!!! FALTA COPIAR EL CODIGO DE LOS PROFES YA QUE ESTE ESTA MUY INCOMPLETO

- de la ppt que vimos en clase:
primer caso: indefinido no sabemos cual sirve mas (los dos funcionaron)
segundo caso: sirve mas herencia (repeticion de logica CREO)
tercer caso: sirve mas composicion (ya que hay que cambiar cosas CREO)
cuarto caso: sirve mas composicion porque en herencia no se puede hacer ya que se deberia usar doble herencia y no vimos nosotros eso (muy complejo)

*/




// FORMA POR COMPOSICION:
class Cliente {
    var salarioMensual = 24000
    var propina

    method cuantoPaga(costoBase) = costoBase + propina.monto(costoBase)
}

object comun {
    method monto(costoBase) = costoBase * 0.1
}

class Comedido {
    var montoMaximo
    method monto(costoBase) = montoMaximo.min(costoBase)
}

object amarrete {
    method monto(costoBase) = 0
}




// FORMA POR HERENCIA:
class Cliente2 {
    var salarioMensual = 24000
    method cuantoPaga(costoBase) = costoBase + self.montoPropina(costoBase)
    method montoPropina(costoBase)

}

class ClienteComun2 inherits Cliente2 {
    override method montoPropina(costoBase) = costoBase * 0.1
}

class ClienteComedido inherits Cliente2 {
    var montoMaximo
    override method montoPropina(costoBase) = montoMaximo.min(costoBase)
}

class ClienteAmarrete inherits Cliente2 {
    override method montoPropina(costoBase) = 0
}