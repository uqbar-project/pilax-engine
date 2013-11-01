package org.uqbar.pilax.ejemplos

import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.actores.Mono

class EjemploMono {
	
	def static void main(String[] args) {
		Pilas.iniciar
		
		val mono = new Mono()
		
		Pilas.instance.ejecutar
	}
	
}