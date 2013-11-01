package org.uqbar.pilax.engine

import org.eclipse.xtext.xbase.lib.Pair

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
	
}