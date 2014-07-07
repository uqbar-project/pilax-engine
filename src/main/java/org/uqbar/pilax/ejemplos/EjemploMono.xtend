package org.uqbar.pilax.ejemplos

import org.uqbar.pilax.actores.ActorMono
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.habilidades.Arrastrable
import org.uqbar.pilax.comportamientos.ComportamientoGirar

class EjemploMono {
	
	def static void main(String[] args) {
		Pilas.iniciar
		
		val mono = new ActorMono(50, 100)
//		mono.aprender(Rota)
		mono.aprender(Arrastrable)
		mono.hacer(new ComportamientoGirar(5, 5))
//		
//		for (i : 1..3) {
//			val estrella = new Item
//			estrella.aprender(Rodear) => [ 
//				actorARodear = mono
//				angulo.incrementar(i * 30)
//			]
//		}
//		
//		mono.decir("Hola mundo!")
//		
//		new ActorTexto("Hola Mundo Mono", 100, 100)
//			.hacerLuego(new ComportamientoGirar(0, 1), true)
		
		Pilas.instance.ejecutar
	}

}