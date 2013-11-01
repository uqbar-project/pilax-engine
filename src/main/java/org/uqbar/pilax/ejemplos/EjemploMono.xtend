package org.uqbar.pilax.ejemplos

import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.actores.Mono
import org.uqbar.pilax.habilidades.SeguirAlMouse

class EjemploMono {
	
	def static void main(String[] args) {
		Pilas.iniciar
		
		val mono = new Mono()
		mono.aprender(SeguirAlMouse)
		
		Pilas.instance.ejecutar
	}
	
}