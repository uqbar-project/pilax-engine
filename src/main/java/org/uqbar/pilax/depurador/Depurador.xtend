package org.uqbar.pilax.depurador

import com.trolltech.qt.gui.QPainter
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.motor.qt.Motor

/**
 * Strategy utilizado para poder habilitar y deshabilitar el depurador.
 */
interface Depurador {
	
	def void comienzaDibujado(Motor motor, QPainter painter)

    def void dibujaAlActor(Motor motor, QPainter painter, Actor actor)

    def void terminaDibujado(Motor motor, QPainter painter)

    def void cuandoPulsaTecla(Tecla codigo_tecla, Object texto_tecla)

    def boolean cuandoMueveElMouse(double x, double y)
	
}