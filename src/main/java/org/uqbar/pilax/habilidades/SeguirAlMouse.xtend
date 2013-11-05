package org.uqbar.pilax.habilidades

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Habilidad
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.eventos.DataEventoMovimiento

class SeguirAlMouse extends Habilidad {
	
	new(Actor receptor) {
		super(receptor)
		Pilas.instance.escenaActual.mueveMouse.conectar("seguir", [DataEventoMovimiento d | mover(d)])
	}
	
	def mover(DataEventoMovimiento evento) {
        this.receptor.x = evento.x.intValue
        this.receptor.y = evento.y.intValue
    }
	
}