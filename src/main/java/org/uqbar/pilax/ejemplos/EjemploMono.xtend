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
//		mono.aprender(RebotarComoPelota)
		mono.aprender(Arrastrable)
		
		for (i : 0..2) {
			val bala = new Item
			bala.aprender(Rodear) => [ 
				actorARodear = mono
				angulo.incrementar(i * 30)
			]
		}
		
//		mono.aprender(SeguirAlMouse)
//		mono.aprender(MoverseConTeclado) => [
//			conRotacion = true
//		]
//		mono.aprender(SeMantieneEnPantalla)
		
		mono.decir("Hola mundo!")
		
//		new ActorPiedra(Tamanio.grande, -20, -20)
		
		new ActorTexto("Hola Mundo Mono", 100, 100)
			.hacerLuego(new ComportamientoGirar(0, 1), true)
		
//		Pilas.instance.escenaActual.pulsaTecla.conectar("monoTeclado") [d|
//			switch (d.tecla) {
//				case Tecla.r: interpolar(mono, "rotacion", #[0, 180, 360])
//				case Tecla.e: interpolar(mono, "escala", #[3, 1, 0, 1])
//				case Tecla.DERECHA: interpolar(mono, "x", #[200])
//				case Tecla.IZQUIERDA: interpolar(mono, "x", #[-200])
//				case Tecla.ARRIBA: interpolar(mono, "y", #[150], new CircEaseOut)
//				case Tecla.ABAJO: interpolar(mono, "y", #[-150], new LinearEasing)
//			}
//		]
		
//		[| new ActorPelota(randint(0, 320), randint(0, 240)) ].nTimes(20)
		
		Pilas.instance.ejecutar
	}

}