package org.uqbar.pilax.actores.animacion

import org.uqbar.pilax.actores.animacion.ActorAnimado
import org.uqbar.pilax.motor.GrillaImagen

class ActorAnimacion extends ActorAnimado {
	int tick
	boolean ciclica
	@Property double velocidad_de_animacion
	
	new(GrillaImagen imagen, double x, double y) {
		this(imagen, x, y, false)
	}
	
	new(GrillaImagen imagen, double x, double y, boolean ciclica) {
		this(imagen, x, y, ciclica, 10)
	}
	
	new(GrillaImagen imagen, double x, double y, boolean ciclica, int velocidad) {
		super(imagen, x, y)
		
		tick = 0
        this.ciclica = ciclica
        velocidad_de_animacion = velocidad
	}
	
	def void setVelocidad_de_animacion(int i) {
		velocidad_de_animacion = (1000.0 / 60) * i
	}
	
	override actualizar() {
        /** Hace avanzar la animacion. */
        tick =  (tick + velocidad_de_animacion).intValue

        if (tick > 1000.0) {
            tick = tick - 1000
            val ha_avanzado = imagen.avanzar

            // Si la animacion ha terminado se elimina de la pantalla.
            if (!ha_avanzado && !ciclica)
                eliminar
        }
	}
		
}