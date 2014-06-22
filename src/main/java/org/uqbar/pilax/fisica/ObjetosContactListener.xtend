package org.uqbar.pilax.fisica

import java.util.UUID
import org.jbox2d.callbacks.ContactImpulse
import org.jbox2d.callbacks.ContactListener
import org.jbox2d.collision.Manifold
import org.jbox2d.dynamics.contacts.Contact
import org.uqbar.pilax.engine.Pilas

import static extension org.uqbar.pilax.utils.PythonUtils.*

class ObjetosContactListener implements ContactListener {
	
	override beginContact(Contact contact) {
		val objeto_colisionado_1 = contact.fixtureA
        val objeto_colisionado_2 = contact.fixtureB
	
        if ( !(objeto_colisionado_1.userData == null) && !(objeto_colisionado_2.userData == null)) {
            Pilas.instance.escenaActual.colisiones.verificarColisionesFisicas(
            	objeto_colisionado_1.userData as UUID,
                objeto_colisionado_2.userData as UUID
            )
		}
	}
	
	override endContact(Contact contact) {
	}
	
	override postSolve(Contact contact, ContactImpulse impulse) {
	}
	
	override preSolve(Contact contact, Manifold oldManifold) {
	}
	
}