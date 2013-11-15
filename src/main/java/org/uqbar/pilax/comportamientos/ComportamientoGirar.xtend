package org.uqbar.pilax.comportamientos

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Comportamiento

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class ComportamientoGirar extends Comportamiento<Actor> {
	double delta
	double velocidad
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

        delta = Math.abs(receptor.rotacion - anguloFinal)

        if (delta <= Math.abs(velocidad)) {
            receptor.rotacion = anguloFinal
            return true
        }
        false
	}
	
}