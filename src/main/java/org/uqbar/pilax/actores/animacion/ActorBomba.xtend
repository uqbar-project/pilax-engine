package org.uqbar.pilax.actores.animacion

import org.uqbar.pilax.actores.animacion.ActorAnimacion
import org.uqbar.pilax.motor.GrillaImagen
import org.uqbar.pilax.habilidades.PuedeExplotar

class ActorBomba extends ActorAnimacion {
	
	new() {
		this(0, 0)
	}

        /** Constructor de la Bomba.

        :param x: Posición horizontal del Actor.
        :type x: int
        :param y: Posición vertical del Actor.
        :type y: int
         */	
	new(int x, int y) {
        super(new GrillaImagen("bomba.png", 2), x, y, true, 10)
        radioDeColision = 25
        aprender(PuedeExplotar)
	}
	
	/** Hace explotar a la bomba y la elimina de la pantalla.*/
    def explotar() {
        eliminar
	}
}