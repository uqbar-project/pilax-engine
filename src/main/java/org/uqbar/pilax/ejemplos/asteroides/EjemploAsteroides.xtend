package org.uqbar.pilax.ejemplos.asteroides

import org.uqbar.pilax.engine.Pilas

class EjemploAsteroides {
	def static void main(String[] args) {
		Pilas.iniciar
		Pilas.instance.cambiarEscena(new EscenaMenu)
		Pilas.instance.ejecutar
	}
	
}