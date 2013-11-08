package org.uqbar.pilax.habilidades

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Habilidad
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.eventos.DataEventoMouse

class SeguirAlMouse extends Habilidad {
	
	new(Actor receptor) {
		super(receptor)
		Pilas.instance.escenaActual.mueveMouse.conectar("seguir", [ d | mover(d)])
	}
	
	def mover(DataEventoMouse evento) {
        this.receptor.x = evento.x.intValue
        this.receptor.y = evento.y.intValue
    }
	
}