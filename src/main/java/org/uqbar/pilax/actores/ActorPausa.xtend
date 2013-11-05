package org.uqbar.pilax.actores

import org.uqbar.pilax.engine.Actor

class ActorPausa extends Actor {
	
	new() {
		this(0, 0)
	}
	
	new(int x, int y) {
		super("icono_pausa.png", x, y)
		this.centro = (0 -> 0)
	}
	
}