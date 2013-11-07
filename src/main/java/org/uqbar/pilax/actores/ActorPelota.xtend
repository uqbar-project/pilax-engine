package org.uqbar.pilax.actores

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.habilidades.RebotarComoPelota

class ActorPelota extends Actor {
	
	new(int x, int y) {
		super("pelota.png", x, y)
		
		rotacion = 0
        radioDeColision = 25
        aprender(RebotarComoPelota)
	}
	
}