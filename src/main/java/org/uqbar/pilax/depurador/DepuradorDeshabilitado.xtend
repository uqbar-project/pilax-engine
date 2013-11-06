package org.uqbar.pilax.depurador

import com.trolltech.qt.gui.QPainter
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.motor.qt.Motor

class DepuradorDeshabilitado implements Depurador {
	
    override comienza_dibujado(Motor motor, QPainter painter) {}

    override dibuja_al_actor(Motor motor, QPainter painter, Actor actor) {}

    override termina_dibujado(Motor motor, QPainter painter) {}

    override cuando_pulsa_tecla(Tecla codigo_tecla, Object texto_tecla) {}

    override boolean cuando_mueve_el_mouse(int x, int y) { true }
}