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

class ModoAngulo extends ModoDepurador {
	
	new(DepuradorImpl impl) {
		super(impl, Tecla.F4)
	}

	override dibujaAlActor(Motor motor, PilasPainter painter, Lienzo lienzo, Actor actor) {
		val longitudRadio = actor.radioDeColision * 2d
        val posicion = actor.posicionRelativaACamara
        
        // ejeY
        lienzo.linea(painter, posicion.x, posicion.y, posicion.x, posicion.y + longitudRadio, Color.white, 2)

		// lineaAngular
		val punto = actor.getPuntoADistanciaSobreRectaRotacion(longitudRadio)
		lienzo.linea(painter, posicion.x, posicion.y, punto.x, punto.y , Color.red, 2)
        
        // texto r=23°
        lienzo.texto(painter, "r=" + actor.rotacion + "°", posicion.x.intValue + 15, posicion.y.intValue + 15, Color.orange)
        
        // TODO: pasar a otro "modo velocidad"
        val anchoRectVelx = actor.velocidad.x * 5
        lienzo.rectangulo(painter, posicion.x, posicion.y, anchoRectVelx, 6, Color.green, 2, true)
        lienzo.texto(painter, "vx=" + actor.velocidad.x, (posicion.x + anchoRectVelx + 6).intValue, posicion.y.intValue, Color.green)
        
        // arriba
        val textoY = actor.arriba / 2 // posicion.y + (techoY - posicion.y) / 2
        lienzo.texto(painter, "up=" + actor.arriba, posicion.x.intValue - 15, textoY.intValue, Color.orange)
		lienzo.linea(painter, posicion.x, 0, posicion.x, actor.arriba, Color.CYAN, 2)
    }
	
}