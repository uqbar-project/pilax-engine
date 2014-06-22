package org.uqbar.pilax.comportamientos

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Comportamiento

class ComportamientoSaltar extends Comportamiento<Actor> {
	@Property double velocidad_inicial
	@Property () => void cuandTermina = [|]
	double suelo
	double velocidad
	
	override iniciar(Actor receptor) {
		super.iniciar(receptor)
        suelo = receptor.y
        velocidad = velocidad_inicial
        //PILAX: sonido
//        sonido_saltar.reproducir()
	}
	
	override boolean actualizar() {
		receptor.y = receptor.y + velocidad
        velocidad = velocidad - 0.3

        if (receptor.y <= suelo) {
            velocidad_inicial = velocidad_inicial / 2.0
            velocidad = velocidad_inicial

            if (velocidad_inicial <= 1) {
                // Si toca el suelo
                receptor.y = suelo
                cuandTermina.apply
                return true
            }
		}
		return false
	}
	
}