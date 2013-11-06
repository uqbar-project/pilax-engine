package org.uqbar.pilax.depurador.modos

import com.trolltech.qt.gui.QPainter
import java.awt.Color
import org.uqbar.pilax.depurador.DepuradorImpl
import org.uqbar.pilax.depurador.ModoDepurador
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.motor.Lienzo
import org.uqbar.pilax.motor.qt.Motor

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class ModoRadiosDeColision extends ModoDepurador {
	
	new(DepuradorImpl impl) {
		super(impl, Tecla.F9)
	}
	
	override dibujaAlActor(Motor motor, QPainter painter, Lienzo lienzo, Actor actor) {
		val posicion = _obtener_posicion_relativa_a_camara(actor)
        lienzo.circulo(painter, posicion.x.intValue, posicion.y.intValue, actor.radioDeColision, Color.white, depurador.grosor_de_lineas.intValue)
	}
	
}