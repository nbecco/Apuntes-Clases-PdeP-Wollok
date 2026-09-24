object casa{

    var property cuidador= tom
    var property quilombero=null
    var property suciedad= 0
    

    method limpiar(cantidad){
        suciedad-= cantidad}
    method sacarQuilombero(){
        quilombero=null
    }
    
    method ensuciar(cantidad){suciedad += cantidad}
    
    method limpiarTotalmente(){
        suciedad =0
    }

    method pasaElDia(){
        cuidador.limpiar(self)
        if(quilombero != null and cuidador.atraparQuilombero(quilombero)){
            quilombero=null
        }

    }
    method pasaLaNoche(){
        cuidador.dormir()
        if(quilombero != null){quilombero.hacerquilombo(self)}
        
    }

}


object tom {
    var energia=0
    method limpiar(unaCasa) {
        energia -= 40
        unaCasa.limpiar(100)
    }
    method velocidad()= 5 + (energia/10)
    method dormir(){
        energia += 50
    }

    method atraparQuilombero(unQuilombero)= self.velocidad()>unQuilombero.velocidad()
        

    
    method interrumpirSueño(){
    energia -= 20
    }

}

object jerry{
    var peso=0

    method hacerquilombo(unaCasa){
        peso +=1
        unaCasa.ensuciar(110)
    }
    method velocidad()= 10-peso
}

object tuffy {
  method velocidad()=10
  method hacerQuilombo(unaCasa) {
    unaCasa.cuidador().interrumpirSueño()
    
  }
}

object robocat{
    method limpiar(unaCasa){
    unaCasa.limpiarTotalmente()
    }
    method atraparQuilombero(unQuilombero)= true
    method dormir(){}
    method interrumpirSueño() {}

}


object pandilla{
const property quilomberos= [jerry,tuffy]
method hacerquilombo(unaCasa){
quilomberos.forEach({quilombero=>quilombero.hacerQuilombo(unaCasa)})
if (quilomberos.size()>3){
    unaCasa.cuidador().interrumpirSueño()
}
}
method velocidad()=quilomberos.map({quilombero=>quilombero.velocidad()}).min()/2
//otra forma de hacer velocidad
/*
 method velocidad(){}
const elMasLento = quilomberos.min({ quilombero => quilombero.velocidad() })
        return elMasLento.velocidad() / 2 
*/
    
}


