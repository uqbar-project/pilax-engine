package org.uqbar.pilax.ejemplos

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.motor.GrillaImagen

class EjemploPinguGrillaImagenes {
	
	def static void main(String[] args) {
		Pilas.iniciar

		val actor = new Actor(new GrillaImagen("pingu.png", 10, 1), 0, 0)

		Pilas.instance.escenaActual.clickDeMouse.conectar("", [d| actor.imagen.avanzar])
		Pilas.instance.avisar("Pulse el boton del mouse para avanzar un cuadro.")
		Pilas.instance.ejecutar
	}
	
}