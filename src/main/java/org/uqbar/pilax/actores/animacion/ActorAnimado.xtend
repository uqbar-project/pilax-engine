package org.uqbar.pilax.actores.animacion

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.motor.GrillaImagen
import org.uqbar.pilax.actores.PosicionCentro

class ActorAnimado extends Actor {
	
	new(GrillaImagen imagen, double x, double y) {
		super(imagen, x, y)
		setCuadro(0)
	}
	
	override GrillaImagen getImagen() {
		super.getImagen() as GrillaImagen
	}

    /** Permite cambiar el cuadro de animación a mostrar
      :param indice: Número del frame de la grilla que se quiere monstrar.
      :type indice: int
     */	
	def void setCuadro(int indice) {
        imagen.setCuadro(indice)
        // FIX: Esta sentencia es muy ambigua, porque no todos actores se deben centrar en ese punto.
        centroRelativo = PosicionCentro.CENTRO -> PosicionCentro.CENTRO
	}
}