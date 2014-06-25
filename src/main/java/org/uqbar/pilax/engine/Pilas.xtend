package org.uqbar.pilax.engine

import java.util.List
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import org.uqbar.pilax.actores.ActorTextoInferior
import org.uqbar.pilax.motor.qt.MotorQT
import org.uqbar.pilax.motor.Motor

class Pilas {
	private static Pilas INSTANCE 
	@Property Mundo mundo
	@Property List<Actor> todosActores = newArrayList
	// para tareas fuera del thread de la UI
	@Property ExecutorService service = Executors.newFixedThreadPool(3)
	
	def static iniciar() {
		INSTANCE = new Pilas
		val motor = crearMotor();
		INSTANCE.mundo = new Mundo(motor, 640, 480)
		INSTANCE.mundo.gestorEscenas.cambiarEscena(new EscenaNormal)
        motor.visible()
	}
	
	def static Motor crearMotor() {
		new MotorQT
	}
	
	def static Pilas instance() {
		INSTANCE
	}
	
	def ejecutar() {
		mundo.ejecutarBuclePrincipal()
		service.shutdownNow		
	}
	
	def EscenaBase escenaActual() {
		mundo.gestorEscenas.escenaActual
	}
	
	def fondos() {
		escenaActual.actores.filter[it.esFondo]
	}
	
	def static void main(String[] args) {
		Pilas.iniciar
		Pilas.instance.ejecutar
	}
	
	def avisar(String mensaje) {
		avisar(mensaje, 5)
	}
	
	def avisar(String mensaje, int retraso) {
		new ActorTextoInferior(mensaje, 0, 0, true, retraso)
	}
	
	def void cambiarEscena(EscenaBase escena) {
    	mundo.gestorEscenas.cambiarEscena(escena)
  	}
  	
  	def void terminar() {
    	mundo.terminar()
    }
	
}