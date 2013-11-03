package org.uqbar.pilax.ejemplos

import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.habilidades.MoverseConTeclado
import org.uqbar.pilax.actores.ActorTexto
import org.uqbar.pilax.actores.ActorMono

class EjemploMono {
	
	def static void main(String[] args) {
		Pilas.iniciar
		
		val mono = new ActorMono()
//		mono.aprender(SeguirAlMouse)
		mono.aprender(MoverseConTeclado)
		mono.decir("Hola mundo!")
		
		new ActorTexto("Hola Mundo Mono", 100, 100) => [
			fuente = "Droid Sans"
		]
		
		Pilas.instance.ejecutar
	}
	
}