package org.uqbar.pilax.engine

class Pilas {
	private static Pilas INSTANCE 
	@Property Mundo mundoActual
	
	def static iniciar() {
		INSTANCE = new Pilas()
		val motor = new Motor;
		INSTANCE._mundoActual = new Mundo(motor, 640, 480)
		INSTANCE._mundoActual.gestorEscenas.cambiarEscena(new EscenaNormal())
	}
	
	def static Pilas instance() {
		INSTANCE
	}
	
	def ejecutar() {
		mundo.ejecutarBuclePrincipal()
	}
	
	def escenaActual() {
		_mundoActual.gestorEscenas.escenaActual
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