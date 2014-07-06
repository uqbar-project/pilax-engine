package org.uqbar.pilax.depurador

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.motor.Motor
import org.uqbar.pilax.motor.PilasPainter

class DepuradorDeshabilitado implements Depurador {
	
    override comienzaDibujado(Motor motor, PilasPainter painter) {}

    override dibujaAlActor(Motor motor, PilasPainter painter, Actor actor) {}

    override terminaDibujado(Motor motor, PilasPainter painter) {}

    override cuandoPulsaTecla(Tecla codigo_tecla, Object texto_tecla) {}

    override boolean cuandoMueveElMouse(double x, double y) { true }
}