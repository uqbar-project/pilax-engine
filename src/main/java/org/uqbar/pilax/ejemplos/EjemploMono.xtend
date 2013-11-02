package org.uqbar.pilax.ejemplos

import org.uqbar.pilax.actores.Mono
import org.uqbar.pilax.actores.Texto
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.habilidades.MoverseConTeclado

class EjemploMono {
	
	def static void main(String[] args) {
		Pilas.iniciar
		
		val mono = new Mono()
//		mono.aprender(SeguirAlMouse)
		mono.aprender(MoverseConTeclado)
		
		new Texto("Hola Mundo Mono", 100, 100)
		
		Pilas.instance.ejecutar
	}
	
}