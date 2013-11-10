package org.uqbar.pilax.depurador

import com.trolltech.qt.gui.QPainter
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.motor.qt.Motor

class DepuradorDeshabilitado implements Depurador {
	
    override comienzaDibujado(Motor motor, QPainter painter) {}

    override dibujaAlActor(Motor motor, QPainter painter, Actor actor) {}

    override terminaDibujado(Motor motor, QPainter painter) {}

    override cuandoPulsaTecla(Tecla codigo_tecla, Object texto_tecla) {}

    override boolean cuandoMueveElMouse(int x, int y) { true }
}