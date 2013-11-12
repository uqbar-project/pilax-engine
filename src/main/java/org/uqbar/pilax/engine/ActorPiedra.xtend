package org.uqbar.pilax.engine

import org.uqbar.pilax.engine.Actor

class ActorPiedra extends Actor {
	protected Tamanio tamanio
	
	new(Tamanio tamanio, int x, int y) {
		super('''piedra_«tamanio.name».png''', x, y)
		this.tamanio = tamanio
		val radios = #{
                Tamanio.grande -> 25,
                Tamanio.media -> 20,
                Tamanio.chica -> 10
                }
        radioDeColision = radios.get(tamanio)
//        aprender(SeMantieneEnPantalla)
	}
	
	override actualizar() {
		rotacion = rotacion + 1
        x = x + delta.key
        y = y + delta.value
	}
	
}

enum Tamanio {
	grande, media, chica
}