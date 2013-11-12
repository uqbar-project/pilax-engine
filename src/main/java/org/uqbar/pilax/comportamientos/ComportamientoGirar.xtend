package org.uqbar.pilax.comportamientos

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Comportamiento

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class ComportamientoGirar extends Comportamiento<Actor> {
	int delta
	int velocidad
	double anguloFinal
	
	new(int delta, int velocidad) {
        this.delta = delta
		this.velocidad = if (delta > 0) velocidad else - velocidad
	}
	
	override iniciar(Actor receptor) {
		super.iniciar(receptor)
		anguloFinal = (receptor.rotacion + delta) % 360
	}

	override actualizar() {
		receptor.rotacion = receptor.rotacion + velocidad

        delta = (receptor.rotacion - anguloFinal).intValue.abs

        if (delta <= velocidad.abs) {
            receptor.rotacion = anguloFinal
            return true
        }
        false
	}
	
}