package org.uqbar.pilax.engine

import org.uqbar.pilax.habilidades.SeMantieneEnPantalla

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class ActorPiedra extends Actor {
	protected Tamanio tamanio
	@Property Pair<Float,Float> movimiento = (0f -> 0f) 
	
	
	new(Tamanio tamanio, int x, int y) {
		super('''piedra_«tamanio.name».png''', x, y)
		this.tamanio = tamanio
		val radios = #{
            Tamanio.grande -> 25,
            Tamanio.media -> 20,
            Tamanio.chica -> 10
        }
        radioDeColision = radios.get(tamanio)
        aprender(SeMantieneEnPantalla)
        rotacion = 0
        delta = origen
	}
	
	override actualizar() {
		rotacion = rotacion + 1
//		x = x + delta.x
//		y = y + delta.y
		x = x + movimiento.x
		y = y + movimiento.y
	}
	
}

enum Tamanio {
	grande, media, chica
}