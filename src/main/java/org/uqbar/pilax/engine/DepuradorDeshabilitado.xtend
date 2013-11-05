package org.uqbar.pilax.engine

import com.trolltech.qt.gui.QPainter
import org.uqbar.pilax.motor.Motor

class DepuradorDeshabilitado {
	
    def comienza_dibujado(Motor motor, QPainter painter) {}

    def dibuja_al_actor(Motor motor, QPainter painter, Actor actor) {}

    def termina_dibujado(Motor motor, QPainter painter) {}

    def cuando_pulsa_tecla(Object codigo_tecla, Object texto_tecla) {}

    def cuando_mueve_el_mouse(int x, int y) {}
}