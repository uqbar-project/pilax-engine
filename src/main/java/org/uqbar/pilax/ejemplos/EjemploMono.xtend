package org.uqbar.pilax.ejemplos

import org.uqbar.pilax.actores.ActorMono
import org.uqbar.pilax.actores.ActorTexto
import org.uqbar.pilax.comportamientos.ComportamientoGirar
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.habilidades.RebotarComoPelota
import org.uqbar.pilax.habilidades.Arrastrable
import org.uqbar.pilax.habilidades.disparar.Bala
import org.uqbar.pilax.habilidades.Rodear
import org.uqbar.pilax.ejemplos.vacavoladora.Item

class EjemploMono {
	
	def static void main(String[] args) {
		Pilas.iniciar
		
		val mono = new ActorMono(50, 100)
		mono.aprender(Arrastrable)
		
		for (i : 1..3) {
			val estrella = new Item
			estrella.aprender(Rodear) => [ 
				actorARodear = mono
				angulo.incrementar(i * 30)
			]
		}
		
		mono.decir("Hola mundo!")
		
		new ActorTexto("Hola Mundo Mono", 100, 100)
			.hacerLuego(new ComportamientoGirar(0, 1), true)
		
		Pilas.instance.ejecutar
	}

}