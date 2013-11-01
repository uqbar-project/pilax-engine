package org.uqbar.pilax.engine

class ActorPausa extends Actor {
	
	new() {
		this(0, 0)
	}
	
	new(int x, int y) {
		super("icono_pausa.png", x, y)
		this.centro = (0 -> 0)
	}
	
}