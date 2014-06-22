package org.uqbar.pilax.engine

import org.uqbar.pilax.habilidades.SeMantieneEnPantalla

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class ActorPiedra extends Actor {
	protected Tamanio tamanio
	@Property Pair<Double,Double> movimiento = (1d -> 1d)
	
	new(Tamanio tamanio, double x, double y) {
		super('''piedra_«tamanio.name».png''', x, y)
		this.posicionAnterior = x -> y
		this.x = x
		this.y = y
		this.tamanio = tamanio
		val radios = #{
            Tamanio.grande -> 25,
            Tamanio.media -> 20,
            Tamanio.chica -> 10
        }
        radioDeColision = radios.get(tamanio)
        aprender(SeMantieneEnPantalla)
        rotacion = 0
	}
	
	override actualizar() {
		rotacion = rotacion + 1
		x = x + movimiento.x
		y = y + movimiento.y
	}
	
}

enum Tamanio {
	grande, media, chica
}