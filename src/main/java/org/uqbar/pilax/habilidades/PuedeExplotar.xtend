package org.uqbar.pilax.habilidades

import org.uqbar.pilax.engine.Habilidad
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.actores.animacion.ActorExplosion
import org.uqbar.pilax.engine.ActorListener
import org.uqbar.pilax.engine.EventChain

class PuedeExplotar extends Habilidad implements ActorListener {
	
	new(Actor receptor) {
        super(receptor)
        receptor.addListener(this)
	}
	
	override eliminar(Actor actor, EventChain chain) {
		val explosion = new ActorExplosion(receptor.x, receptor.y)
        explosion.escala = receptor.escala * 2		
		chain.proceed(actor)
	}
	
}