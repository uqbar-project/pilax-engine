package org.uqbar.pilax.fisica

import org.jbox2d.dynamics.Body
import org.jbox2d.dynamics.BodyDef
import org.jbox2d.dynamics.joints.JointType
import org.jbox2d.dynamics.joints.MouseJoint
import org.jbox2d.dynamics.joints.MouseJointDef
import org.uqbar.pilax.engine.Pilas

import static extension org.uqbar.pilax.fisica.box2d.Box2DExtensions.*

class ConstanteDeMovimiento {
	Body cuerpo_enlazado
	Figura figura_cuerpo
	MouseJoint constante
	
	new(Figura figura) {
        /** Inicializa la constante.

        :param figura: Figura a controlar desde el mouse.
        */
        // CAST !
        val mundo = (Pilas.instance.escenaActual.fisica as Fisica).mundo
        val punto_captura = figura.x.aMetros -> figura.y.aMetros
        cuerpo_enlazado = mundo.createBody(new BodyDef)
        figura_cuerpo = figura
        constante = mundo.createJoint(new MouseJointDef() => [
        	type = JointType.MOUSE
        	bodyA = cuerpo_enlazado
        	bodyB = figura.cuerpo
        	target.set(punto_captura.key.floatValue, punto_captura.value.floatValue) 
            maxForce = 1000.0f * figura.cuerpo.mass
        ]) as MouseJoint
        figura.cuerpo.awake = true
	}
	
	def mover(int x, int y) {
       /**Realiza un movimiento de la figura.

        :param x: Posición horizontal.
        :param y: Posición vertical.
        */
        constante.target.set(x.aMetros, y.aMetros)
    }

    def eliminar() {
        // Si se intenta destruir un Joint de un cuerpo que ya no existe, se cierra
        // la aplicación.
        //pilas.escena_actual().fisica.mundo.DestroyJoint(self.constante)
        (Pilas.instance.escenaActual.fisica as Fisica).mundo.destroyBody(cuerpo_enlazado)
	}
	
}