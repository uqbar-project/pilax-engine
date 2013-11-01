package org.uqbar.pilax.engine

import java.util.List

class Pilas {
	private static Pilas INSTANCE 
	@Property Mundo mundoActual
	@Property List<Actor> todosActores = newArrayList
	
	def static iniciar() {
		INSTANCE = new Pilas()
		val motor = new Motor;
		INSTANCE._mundoActual = new Mundo(motor, 640, 480)
		INSTANCE._mundoActual.gestorEscenas.cambiarEscena(new EscenaNormal())
        motor.ventana.show
	}
	
	def static Pilas instance() {
		INSTANCE
	}
	
	def ejecutar() {
		mundo.ejecutarBuclePrincipal()
	}
	
	def escenaActual() {
		mundoActual.gestorEscenas.escenaActual
	}
	
	def fondos() {
		escenaActual.actores.filter[it.esFondo]
	}
	
	def getMundo() {
		this._mundoActual
	}

	def static void main(String[] args) {
		Pilas.iniciar
		Pilas.instance.ejecutar
	}
		
	
}