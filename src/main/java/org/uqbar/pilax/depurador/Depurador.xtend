package org.uqbar.pilax.depurador

import com.trolltech.qt.gui.QPainter
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.motor.qt.Motor

interface Depurador {
	
	def void comienza_dibujado(Motor motor, QPainter painter)

    def void dibuja_al_actor(Motor motor, QPainter painter, Actor actor)

    def void termina_dibujado(Motor motor, QPainter painter)

    def void cuando_pulsa_tecla(Tecla codigo_tecla, Object texto_tecla)

    def boolean cuando_mueve_el_mouse(int x, int y)
	
}