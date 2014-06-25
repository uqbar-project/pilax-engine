package org.uqbar.pilax.depurador

import com.trolltech.qt.gui.QPainter
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.motor.qt.MotorQT

class DepuradorDeshabilitado implements Depurador {
	
    override comienzaDibujado(MotorQT motor, QPainter painter) {}

    override dibujaAlActor(MotorQT motor, QPainter painter, Actor actor) {}

    override terminaDibujado(MotorQT motor, QPainter painter) {}

    override cuandoPulsaTecla(Tecla codigo_tecla, Object texto_tecla) {}

    override boolean cuandoMueveElMouse(double x, double y) { true }
}