package org.uqbar.pilax.engine

import java.util.List
import org.uqbar.pilax.motor.Motor

class Pilas {
	private static Pilas INSTANCE 
	@Property Mundo mundo
	@Property List<Actor> todosActores = newArrayList
	
	def static iniciar() {
		INSTANCE = new Pilas()
		val motor = new Motor;
		INSTANCE.mundo = new Mundo(motor, 640, 480)
		INSTANCE.mundo.gestorEscenas.cambiarEscena(new EscenaNormal())
        motor.ventana.show
	}
	
	def static Pilas instance() {
		INSTANCE
	}
	
	def ejecutar() {
		mundo.ejecutarBuclePrincipal()
	}
	
	def escenaActual() {
		mundo.gestorEscenas.escenaActual
	}
	
	def fondos() {
		escenaActual.actores.filter[it.esFondo]
	}
	
	def static void main(String[] args) {
		Pilas.iniciar
		Pilas.instance.ejecutar
	}
	
}