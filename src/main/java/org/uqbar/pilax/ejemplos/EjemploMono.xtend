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

class EjemploMono {
	
	def static void main(String[] args) {
		Pilas.iniciar
		
		val mono = new ActorMono(50, 100)
//		mono.aprender(RebotarComoPelota)
//		mono.aprender(SeguirAlMouse)
//		mono.aprender(MoverseConTeclado) 
		
//		mono.decir("Hola mundo!") anda pero causa una exception. Creo que la habilidad no se muere y sigue
		
		new ActorTexto("Hola Mundo Mono", 100, 100)
			.hacerLuego(new ComportamientoGirar(0, 1), true)
		
		Pilas.instance.escenaActual.pulsaTecla.conectar("monoTeclado") [d|
			if (d.tecla == Tecla.r) interpolar(mono, "rotacion", #[0, 180, 360])
			if (d.tecla == Tecla.e) interpolar(mono, "escala", #[3, 1, 0, 1])
			if (d.tecla == Tecla.DERECHA) interpolar(mono, "x", #[200])
			if (d.tecla == Tecla.IZQUIERDA) interpolar(mono, "x", #[-200])
			if (d.tecla == Tecla.ARRIBA) interpolar(mono, "y", #[150], new CircEaseOut)
			if (d.tecla == Tecla.ABAJO) interpolar(mono, "y", #[-150], new LinearEasing)
		]
		
		[| new ActorPelota(randint(0, 320), randint(0, 240)) ].nTimes(20)
		
		Pilas.instance.ejecutar
	}

}