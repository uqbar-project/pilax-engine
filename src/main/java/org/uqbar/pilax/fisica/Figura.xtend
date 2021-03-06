package org.uqbar.pilax.fisica

import java.util.UUID
import org.eclipse.xtext.xbase.lib.Pair
import org.jbox2d.common.Vec2
import org.jbox2d.dynamics.Body
import org.uqbar.pilax.comunes.ObjetoGrafico
import org.uqbar.pilax.engine.Pilas

import static extension org.uqbar.pilax.fisica.box2d.Box2DExtensions.*
import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

class Figura implements ObjetoGrafico {
	@Property UUID id
	@Property Body cuerpo
	
	new() {
		id = uuid()
	}
	
	/** Quita una figura de la simulación. */
	def eliminar() {
		escena.fisica.eliminarFigura(this)
	}

	def getEscena() {
		Pilas.instance.escenaActual
	}
	
	override getX() {
		cuerpo.position.x.aPixels
	}
	
	override setX(double x) {
		cuerpo.position.set(x.aMetros.floatValue, cuerpo.position.y)
	}
	
	override getY() {
		cuerpo.position.y.aPixels
	}
	
	override setY(double y) {
		cuerpo.position.set(cuerpo.position.x, y.aMetros.floatValue)
	}
	
	override getRotacion() {
		-Math.toDegrees(cuerpo.angle)
	}
	
	def impulsar(float dx, float dy) {
        // TODO: convertir los valores dx y dy a metros.
        cuerpo.applyLinearImpulse(new Vec2(dx, dy), new Vec2(0, 0))
	}
	
	def empujar(int dx, int dy) {
        // TODO: convertir a metros???
        velocidadLineal = (dx -> dy)
	}
	
	def getVelocidadLineal() {
		val velocidad = self._cuerpo.linearVelocity
        return (velocidad.x -> velocidad.y)
	}
	
	def setVelocidadLineal(Pair<Integer,Integer> vel) {
        // TODO: convertir a metros
        val anterior = velocidadLineal

		var dx = if (vel.x == null) anterior.x else 0f
		var dy = if (vel.y == null) anterior.y else 0f

        val b2vec = _cuerpo.linearVelocity
        b2vec.x = dx
        b2vec.y = dy

        // Añadimos el try, porque aparece el siguiente error:
        // TypeError: in method 'b2Vec2___call__', argument 2 of type 'int32'
        try {
            _cuerpo.linearVelocity = b2vec
        }
        catch (RuntimeException e) {
        	e.printStackTrace
        }
            
	}
}