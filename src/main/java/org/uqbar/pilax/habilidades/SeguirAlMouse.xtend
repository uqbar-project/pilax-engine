package org.uqbar.pilax.habilidades

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Habilidad
import org.uqbar.pilax.eventos.DataEventoMouse

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class SeguirAlMouse extends Habilidad {
	
	new(Actor receptor) {
		super(receptor)
		eventos.mueveMouse.conectar("seguir", [ d | mover(d)])
	}
	
	def mover(DataEventoMouse evento) {
        this.receptor.x = evento.posicion.x.intValue
        this.receptor.y = evento.posicion.y.intValue
    }
	
}