package org.uqbar.pilax.actores

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.utils.PilasExtensions

class ActorPausa extends Actor {
	
	new() {
		this(0, 0)
	}
	
	new(int x, int y) {
		super("icono_pausa.png", x, y)
		this.centro = PilasExtensions.origen
	}
	
}