package org.uqbar.pilax.actores.animacion

import org.uqbar.pilax.actores.animacion.ActorAnimado
import org.uqbar.pilax.motor.GrillaImagen

class ActorAnimacion extends ActorAnimado {
	int tick
	boolean ciclica
	double velocidad_de_animacion
	
	new(GrillaImagen imagen, int x, int y) {
		this(imagen, x, y, false, 10)
	}
	
	new(GrillaImagen imagen, int x, int y, boolean ciclica, int velocidad) {
		super(imagen, x, y)
		
		tick = 0
        this.ciclica = ciclica
        definir_velocidad_de_animacion(velocidad)
	}
	
	def definir_velocidad_de_animacion(int i) {
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