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

class ModoArea extends ModoDepurador {
	
	new(DepuradorImpl depurador) {
		super(depurador, Tecla.F10)
	}
	
    override dibujaAlActor(Motor motor, PilasPainter painter, Lienzo lienzo, Actor actor) {
        val centroActor = actor.centro
        val posicion = actor.posicionRelativaACamara
        lienzo.rectangulo(painter, posicion.x - centroActor.x, posicion.y + centroActor.y, actor.ancho, actor.alto, Color.white, depurador.grosor_de_lineas.intValue)
    }
	
	
}