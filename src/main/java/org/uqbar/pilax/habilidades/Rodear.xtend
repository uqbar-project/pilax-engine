package org.uqbar.pilax.habilidades

import org.uqbar.pilax.engine.Habilidad
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.geom.Angulo

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class Rodear extends Habilidad {
	@Property Actor actorARodear
	@Property double velocidadAngular = -5d
	@Property double distanciaEntreRadios = 10
	Angulo angulo
	
	new(Actor receptor) {
		super(receptor)
		angulo = new Angulo
	}
	
	override actualizar() {
		receptor.posicion = actorARodear.posicion + polarACartesiana(angulo, radio)
		angulo += velocidadAngular
	}
	
	/**
	 * Distancia radial desde el actor al que lo rodea
	 */
	def radio() {
		actorARodear.radioDeColision + receptor.radioDeColision + distanciaEntreRadios
	}

	def getAngulo() {
		angulo
	}
	
}