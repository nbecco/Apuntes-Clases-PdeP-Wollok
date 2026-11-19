// PARTE A

// 1) y 2)
class Producto {
  var dedicatoria = sinDedicatoria

  method precio() = self.precioBase() + dedicatoria.precio()

  method precioBase()

  method calorias()

  method esAptoCeliacos() = false

  // 2) poner y cambiar es lo mismo: se reemplaza la dedicatoria
  method ponerDedicatoria(texto) {
    dedicatoria = new Dedicatoria(texto = texto)
  }

  method quitarDedicatoria() {
    dedicatoria = sinDedicatoria
  }

  // B3) un producto comun es su propio producto individual
  method productosIndividuales() = [self]
}

class Dedicatoria {
  const texto

  method precio() = 500 + 20 * texto.size()
}

object sinDedicatoria {
  method precio() = 0
}

class Cupcake inherits Producto {
  const gramosCobertura

  override method precioBase() = 1500 + 10 * gramosCobertura

  override method calorias() = 200 + 5 * gramosCobertura
}

class Torta inherits Producto {
  const porciones

  override method precioBase() =
    if (porciones > 8) self.precioPorciones() * 0.9 else self.precioPorciones()

  method precioPorciones() = 2000 * porciones

  override method calorias() = self.caloriasPorPorcion() * porciones

  method caloriasPorPorcion() = 350
}

// supuesto: el 30% se aplica sobre el precio de la torta ya con el descuento
class TortaSinTacc inherits Torta {
  override method precioBase() = super() * 1.3

  override method caloriasPorPorcion() = super() - 50

  override method esAptoCeliacos() = true
}

// supuesto: los $300 son por galletita (sale del Anexo: 12 galletitas = $3600)
class PaqueteDeGalletitas inherits Producto {
  const cantidad

  override method precioBase() = 300 * cantidad

  override method calorias() = 80 * cantidad
}

// 3)
class Pedido {
  const productos = []

  // 3a)
  method agregar(producto) {
    productos.add(producto)
  }

  // 3b)
  method precioTotal() = productos.sum({ producto => producto.precio() })

  // 3c)
  method esAptoCeliacos() = productos.all({ producto => producto.esAptoCeliacos() })

  // 3d) supuesto: el pedido tiene al menos un producto
  method productoMasCaro() = productos.max({ producto => producto.precio() })

  method estaVacio() = productos.isEmpty()

  // B3) las cajas no cuentan, se busca dentro de ellas
  method productoMasCalorico() =
    productos.flatMap({ producto => producto.productosIndividuales() }).max({ producto => producto.calorias() })
}

// 4)
object pasteleria {
  const entregas = []

  method entregar(pedido) {
    if (pedido.estaVacio()) throw new DomainException(message = "No se puede entregar un pedido sin productos")
    // 4a) lo cobrado se fija al entregar, no se recalcula
    entregas.add(new Entrega(pedido = pedido, montoCobrado = pedido.precioTotal()))
  }

  method recaudacion() = entregas.sum({ entrega => entrega.montoCobrado() })
}

class Entrega {
  const pedido
  const property montoCobrado
}

// PARTE B

// B1) la caja es un producto mas (hereda la dedicatoria) que contiene otros productos
class Caja inherits Producto {
  const contenido = []

  method agregar(producto) {
    contenido.add(producto)
  }

  method sacar(producto) {
    contenido.remove(producto)
  }

  override method precioBase() = 800 + 0.9 * contenido.sum({ producto => producto.precio() })

  override method calorias() = contenido.sum({ producto => producto.calorias() })

  override method esAptoCeliacos() = contenido.all({ producto => producto.esAptoCeliacos() })

  override method productosIndividuales() = contenido.flatMap({ producto => producto.productosIndividuales() })
}

// PARTE C

/*
1) Problemas del diseño planteado

- Categoria por herencia (ClienteFrecuente, ClienteVIP): la categoria cambia en ejecucion
  (sube con los pedidos y baja al cancelar) y un objeto no puede cambiar de clase.
  Por eso actualizarCategorias() tiene que crear otra instancia y copiar los pedidos: se pierde
  la identidad del cliente (quien conocia al viejo sigue apuntando al viejo) y la logica es compleja.
- ClienteVIP hereda de ClienteFrecuente "porque tiene mas beneficios": no es un "es un", reutiliza
  por conveniencia y despues tiene que redefinir todo (descuento, costoEnvio). Queda acoplado.
- Flags esFrecuente / esVip: son redundantes con la clase, permiten estados invalidos
  (los dos en true, o esVip en un ClienteFrecuente) y obligan a encadenar ifs para saber a que bajar.
- tipo() devuelve un string y el gestor hace un if por cada categoria: es preguntar el tipo en vez de
  usar polimorfismo. Agregar una categoria obliga a tocar los ifs de aplicarDescuento y costoEnvio.
- gestorDeClientes es un objeto manager / God Object: calcula descuentos y envio, cuenta pedidos y
  cambia categorias de objetos que no son suyos. Rompe el encapsulamiento: la responsabilidad
  deberia estar en el cliente y en su categoria. Ademas la categoria solo se actualiza cuando
  alguien se acuerda de llamar a actualizarCategorias().
- cantidadPedidos se guarda (y la incrementa el gestor) cuando se puede calcular con pedidos.size():
  se puede desincronizar (por ejemplo, al cancelar un pedido nadie la resta).

2) Propuesta: composicion (state). El cliente tiene una categoria que puede cambiar,
   y cada categoria sabe cuanto se paga, a cual sube y a cual baja.

class Cliente {
  const pedidos = []
  var categoria = comun

  method cantidadPedidos() = pedidos.size()                 // se calcula

  method registrarPedido(pedido) {
    pedidos.add(pedido)
    categoria = categoria.categoriaSegun(self.cantidadPedidos())
  }

  // supuesto: el pedido cancelado se saca de los pedidos del cliente
  method cancelarPedido(pedido) {
    pedidos.remove(pedido)
    categoria = categoria.bajar()
  }

  method montoAPagar(pedido) = categoria.montoAPagar(pedido.precioTotal())
}

object comun {
  method montoAPagar(precio) = precio + 1000
  method categoriaSegun(cantidad) = if (cantidad > 5) frecuente else self
  method bajar() = self
}

object frecuente {
  method montoAPagar(precio) = precio * 0.9 + 1000
  method categoriaSegun(cantidad) = if (cantidad > 20) vip else self
  method bajar() = comun
}

object vip {
  method montoAPagar(precio) = precio * 0.8
  method categoriaSegun(_) = self
  method bajar() = frecuente
}

Diagrama:

  Pedido  ◀──────*  Cliente  ──────▶  «Categoria»  (montoAPagar(precio), categoriaSegun(cant), bajar())
                                          △
                         - - - - - - - - -┼- - - - - - - - -
                         ┊                ┊                ┊
                  comun <object>   frecuente <object>   vip <object>

- Ya no hacen falta gestorDeClientes, tipo(), los flags ni las subclases de Cliente.
- Una categoria nueva es un objeto nuevo que entiende los mismos tres mensajes.
*/
