package org.uqbar.pilax.depurador.modos

import com.trolltech.qt.gui.QPainter
import java.awt.Color
import org.uqbar.pilax.depurador.DepuradorImpl
import org.uqbar.pilax.depurador.ModoDepurador
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.motor.Lienzo

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import org.uqbar.pilax.motor.qt.MotorQT

class ModoPuntosDeControl extends ModoDepurador {
	
	new(DepuradorImpl impl) {
		super(impl, Tecla.F8)
	}
	
	override dibujaAlActor(MotorQT motor, QPainter painter, Lienzo lienzo, Actor actor) {
		val posicion = actor.posicionRelativaACamara
        lienzo.cruz(painter, posicion.x.intValue, posicion.y.intValue, Color.white, depurador.grosor_de_lineas.intValue)
	}
	
}