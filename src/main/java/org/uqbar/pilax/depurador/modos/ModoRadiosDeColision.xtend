package org.uqbar.pilax.depurador.modos

import java.awt.Color
import org.uqbar.pilax.depurador.DepuradorImpl
import org.uqbar.pilax.depurador.ModoDepurador
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.motor.Lienzo
import org.uqbar.pilax.motor.Motor
import org.uqbar.pilax.motor.PilasPainter

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class ModoRadiosDeColision extends ModoDepurador {
	
	new(DepuradorImpl impl) {
		super(impl, Tecla.F9)
	}
	
	override dibujaAlActor(Motor motor, PilasPainter painter, Lienzo lienzo, Actor actor) {
		val posicion = actor.posicionRelativaACamara
        lienzo.circulo(painter, posicion.x.intValue, posicion.y.intValue, actor.radioDeColision, Color.white, depurador.grosor_de_lineas.intValue)
	}
	
}