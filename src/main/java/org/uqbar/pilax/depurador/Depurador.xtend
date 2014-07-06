package org.uqbar.pilax.depurador

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.motor.Motor
import org.uqbar.pilax.motor.PilasPainter

/**
 * Strategy utilizado para poder habilitar y deshabilitar el depurador.
 */
interface Depurador {
	
	def void comienzaDibujado(Motor motor, PilasPainter painter)

    def void dibujaAlActor(Motor motor, PilasPainter painter, Actor actor)

    def void terminaDibujado(Motor motor, PilasPainter painter)

    def void cuandoPulsaTecla(Tecla codigo_tecla, Object texto_tecla)

    def boolean cuandoMueveElMouse(double x, double y)
	
}