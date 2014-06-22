package org.uqbar.pilax.actores

import org.uqbar.pilax.engine.Actor

class ActorEjes extends Actor {
	
	new() {
		this(0, 0)
	}
	
	new(int x, int y) {
		super("ejes.png", x, y)
		z = 100
	}
	
}