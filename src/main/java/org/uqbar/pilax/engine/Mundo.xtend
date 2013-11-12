package org.uqbar.pilax.engine

import org.eclipse.xtext.xbase.lib.Functions.Function0
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.fisica.Fisica
import org.uqbar.pilax.motor.qt.Motor

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
	
	def void ejecutarBuclePrincipal() {
		motor.ejecutarBuclePrincipal(this)
	}
	
	def crearMotorFisica() {
		return Fisica.crearMotorFisica(motor.area, gravedad)
	}
	
	def getArea() {
		motor.area
	}
	
	def getControl() {
        return escenaActual.control
	}
	
	// *********************************
	// ** TAREAS
	// *********************************
	
	def agregarTareaUnaVez(float timeOut, Function0<Boolean> function) { // tenia params
        return tareas.unaVez(timeOut, function)
    }
    
    def agregarTarea(float timeOut, Function0<Boolean> function) {
        return tareas.condicional(timeOut, function)
	}

	def protected getTareas() {
		escenaActual.tareas
	}
	
	def getColisiones() {
        return escenaActual.colisiones
    }

	def escenaActual() {
		gestorEscenas.escenaActual
	}
	
	def terminar() {
		motor.terminar
	}
}