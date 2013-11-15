package org.uqbar.pilax.engine

import org.uqbar.pilax.habilidades.SeMantieneEnPantalla

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class ActorPiedra extends Actor {
	protected Tamanio tamanio
	@Property Pair<Float,Float> movimiento = (0f -> 0f) 
	
	
	new(Tamanio tamanio, double x, double y, double dx, double dy) {
		super('''piedra_«tamanio.name».png''', x, y)
		this.x = x
		this.y = y
		this.posicionAnterior = dx -> dy
		this.tamanio = tamanio
		val radios = #{
            Tamanio.grande -> 25,
            Tamanio.media -> 20,
            Tamanio.chica -> 10
        }
        radioDeColision = radios.get(tamanio)
        aprender(SeMantieneEnPantalla)
        rotacion = 0
        posicionAnterior = origen
	}
	
	override actualizar() {
		rotacion = rotacion + 1
//		x = x + posicionAnterior.x
//		y = y + posicionAnterior.y
		x = x + velocidad.x
		y = y + velocidad.y
	}
	
}

enum Tamanio {
	grande, media, chica
}