package org.uqbar.pilax.actores.animacion

import org.uqbar.pilax.motor.GrillaImagen

class ActorExplosion extends ActorAnimacion {
	
		/** Constructor de la Explosion

        :param x: Posición horizontal de la explosion.
        :type x: int
        :param y: Posición vertical de la explosion.
        :type y: int
        */
	new(int x, int y) {
		super(new GrillaImagen("explosion.png", 7), x, y)
		// sonido
//        sonido_explosion = pilas.sonidos.cargar("explosion.wav")
//        sonido_explosion.reproducir()
	}
	
}