package org.uqbar.pilax.ejemplos

import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.actores.pingu.ActorPingu
import org.uqbar.pilax.utils.Utils
import org.uqbar.pilax.fondos.FondoDesplazamientoHorizontal
import org.uqbar.pilax.habilidades.SeMantieneEnPantalla

/**
 * Example of a scene that moves as the character moves left, or right.
 * 
 * @author jfernandes
 */
class EjemploFondoDesplazamiento {
	static ActorPingu p
	
	def static void main(String[] args) {
		Pilas.iniciar
		
		val fondo = new FondoDesplazamientoHorizontal

		fondo.agregar("cielo.png", 0)
		fondo.agregar("montes.png", 0, 100, 0.5)
		fondo.agregar("arboles.png", 0, 100, 0.9)
		fondo.agregar("pasto.png", 0, 375, 2)
		
		p = new ActorPingu(0, -130)
		p.aprender(SeMantieneEnPantalla)
		
		Pilas.instance.mundo.agregarTarea(1/10.0f, [|cambiarPosicionCamara])
		Pilas.instance.avisar("Utiliza el teclado para mover al personaje.")
		Pilas.instance.ejecutar
	}
	
	def static cambiarPosicionCamara() {
		Utils.interpolar(Pilas.instance.escenaActual.camara, "x", #[p.x], 0.1)
		return true
	}
	
}