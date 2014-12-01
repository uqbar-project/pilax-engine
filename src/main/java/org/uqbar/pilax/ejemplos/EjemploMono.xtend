package org.uqbar.pilax.ejemplos

import org.uqbar.pilax.actores.ActorMono
import org.uqbar.pilax.ejemplos.vacavoladora.Item
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.habilidades.Arrastrable
import org.uqbar.pilax.habilidades.MoverseConTeclado

class EjemploMono {
	
	def static void main(String[] args) {
		Pilas.iniciar
		
		val mono = new ActorMono(50, 100)
		mono.aprender(Arrastrable)
		mono.aprender(MoverseConTeclado)
//		mono.hacerLuego(new ComportamientoGirar(5, 5), true)
//		
		for (i : 1..3) {
			val estrella = new Item
//			estrella.aprender(Rodear) => [ 
//				actorARodear = mono
//				angulo.incrementar(i * 30)
//			]
		}
//		
//		mono.decir("Hola mundo!")
//		
//		new ActorTexto("Hola Mundo Mono", 100, 100)
//			.hacerLuego(new ComportamientoGirar(0, 1), true)
		
		Pilas.instance.ejecutar
	}

}