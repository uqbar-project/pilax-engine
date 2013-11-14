package org.uqbar.pilax.ejemplos

import org.uqbar.pilax.actores.ActorMono
import org.uqbar.pilax.actores.ActorTexto
import org.uqbar.pilax.comportamientos.ComportamientoGirar
import org.uqbar.pilax.engine.ActorPiedra
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.engine.Tamanio
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.interpolacion.tweener.easing.CircEaseOut
import org.uqbar.pilax.interpolacion.tweener.easing.LinearEasing

import static org.uqbar.pilax.utils.Utils.*

class EjemploMono {
	
	def static void main(String[] args) {
		Pilas.iniciar
		
		val mono = new ActorMono(50, 100)
//		mono.aprender(RebotarComoPelota)
//		mono.aprender(SeguirAlMouse)
//		mono.aprender(MoverseConTeclado) 
		
		mono.decir("Hola mundo!")
		
		new ActorPiedra(Tamanio.grande, -20, -20)
		
		new ActorTexto("Hola Mundo Mono", 100, 100)
			.hacerLuego(new ComportamientoGirar(0, 1), true)
		
		Pilas.instance.escenaActual.pulsaTecla.conectar("monoTeclado") [d|
			switch (d.tecla) {
				case Tecla.r: interpolar(mono, "rotacion", #[0, 180, 360])
				case Tecla.e: interpolar(mono, "escala", #[3, 1, 0, 1])
				case Tecla.DERECHA: interpolar(mono, "x", #[200])
				case Tecla.IZQUIERDA: interpolar(mono, "x", #[-200])
				case Tecla.ARRIBA: interpolar(mono, "y", #[150], new CircEaseOut)
				case Tecla.ABAJO: interpolar(mono, "y", #[-150], new LinearEasing)
			}
		]
		
//		[| new ActorPelota(randint(0, 320), randint(0, 240)) ].nTimes(20)
		
		Pilas.instance.ejecutar
	}
	
}