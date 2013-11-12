package org.uqbar.pilax.ejemplos

import org.uqbar.pilax.actores.ActorMono
import org.uqbar.pilax.actores.ActorTexto
import org.uqbar.pilax.comportamientos.ComportamientoGirar
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.interpolacion.tweener.easing.CircEaseOut
import org.uqbar.pilax.interpolacion.tweener.easing.LinearEasing
import static extension org.uqbar.pilax.utils.Utils.*
import static extension org.uqbar.pilax.utils.PythonUtils.*
import static extension org.uqbar.pilax.utils.PilasExtensions.* 
import org.uqbar.pilax.habilidades.RebotarComoPelota
import org.uqbar.pilax.actores.ActorPelota
import java.util.List
import org.eclipse.xtext.xbase.lib.Procedures.Procedure0
import org.eclipse.xtext.xbase.lib.Functions.Function0

class EjemploMono {
	
	def static void main(String[] args) {
		Pilas.iniciar
		
		val mono = new ActorMono(50, 100)
//		mono.aprender(RebotarComoPelota)
//		mono.aprender(SeguirAlMouse)
//		mono.aprender(MoverseConTeclado) 
		
		mono.decir("Hola mundo!")
		
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