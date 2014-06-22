package org.uqbar.pilax.engine

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.habilidades.RebotarComoPelota

class Pelota extends Actor {
	
	new(double x, double y) {
		super("pelota.png", x, y)
		rotacion = 0
        radioDeColision = 25
        aprender(RebotarComoPelota)
	}
	
}