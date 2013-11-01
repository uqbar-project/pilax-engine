package org.uqbar.pilax.engine

import org.eclipse.xtext.xbase.lib.Pair
import org.eclipse.xtext.xbase.lib.Functions.Function0

class Mundo {
	@Property GestorEscenas gestorEscenas
	@Property Motor motor
	Pair<Integer,Integer> gravedad
	
	new(Motor motor, int ancho, int alto) {
		this.motor = motor
		this.gestorEscenas = new GestorEscenas
		this.motor.iniciarVentana(ancho, alto, "PilaX (Pilas Engine en XTend)", false, gestorEscenas, 60)
        gravedad = (0 -> -10)
	}
	
	def ejecutarBuclePrincipal() {
		motor.ejecutarBuclePrincipal(this)
	}
	
	def crearMotorFisica() {
		return Fisica.crearMotorFisica(motor.area, gravedad)
	}
	
	// *********************************
	// ** TAREAS
	// *********************************
	
	def agregarTareaUnaVez(int time_out, Function0<Boolean> function) { // tenia params
        return gestorEscenas.escenaActual.tareas.unaVez(time_out, function)
    }
	
}