package org.uqbar.pilax.habilidades.disparar

import java.util.List
import org.uqbar.pilax.engine.Actor

abstract class Municion {
	@Property List<Actor> proyectiles = newArrayList
	
	def void disparar(double x, double y, double rotacion, double angulo_de_movimiento, double offset_disparo_x, double offset_disparo_y)

    def void agregarProyectil(Actor proyectil) {
        proyectiles.add(proyectil)
    }
	
}