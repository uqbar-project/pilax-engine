package org.uqbar.pilax.depurador.modos

import com.trolltech.qt.gui.QPainter
import java.awt.Color
import org.uqbar.pilax.actores.ActorEjes
import org.uqbar.pilax.depurador.DepuradorImpl
import org.uqbar.pilax.depurador.ModoDepurador
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.motor.Lienzo
import org.uqbar.pilax.motor.qt.Motor

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class ModoPosicion extends ModoDepurador {
	ActorEjes eje
	
	new(DepuradorImpl depurador) {
        super(depurador, Tecla.F12)
        eje = new ActorEjes
    }
    
	override dibujaAlActor(Motor motor, QPainter painter, Lienzo lienzo, Actor actor) {
        if (!actor.esFondo) {
            val texto = '''(«actor.x»,«actor.y»)'''
            val dx = actor.x - actor.derecha
           	val dy = actor.y - actor.abajo + 10
            val posicion = _obtener_posicion_relativa_a_camara(actor)
            lienzo.texto(painter, texto, (posicion.x - dx).intValue, (posicion.y - dy).intValue, Color.white)
        }
    }

	override sale_del_modo() {
		eje.eliminar()
	}

}