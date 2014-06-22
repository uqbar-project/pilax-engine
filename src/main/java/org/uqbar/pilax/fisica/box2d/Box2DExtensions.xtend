package org.uqbar.pilax.fisica.box2d

import org.eclipse.xtext.xbase.lib.Pair
import org.jbox2d.common.Vec2
import org.jbox2d.dynamics.Body
import org.jbox2d.collision.shapes.CircleShape
import org.jbox2d.dynamics.Fixture
import org.jbox2d.common.Transform

class Box2DExtensions {
	
	def static asVec(Pair<Double,Double> pair) {
		new Vec2(pair.key.floatValue, pair.value.floatValue)
	}
	
	def static asPair(Vec2 v) {
		v.x.doubleValue -> v.y.doubleValue
	}
	
	public static val PPM = 30f
	
	/** Convierte una magnitid de pixels a metros.*/
	def static aMetros(int pixeles) {
		return pixeles / PPM
	}
	
	def static aMetros(double pixeles) {
		return pixeles / PPM
	}
	
	def static aPixels(float metros) {
		metros * PPM
	}
	
	def static boolean in(Body a, Body list) {
    	return a == list || a.in(list.next)
    }
	
	def static Iterable<Body> asIterable(Body a) {
    	return [| new BodyIterator(a)]
    }
    
    def static Iterable<Fixture> asIterable(Fixture f) {
    	return [| new FixtureIterator(f)]
    }
 
 	def static CircleShape(float radius) {
 		val c = new CircleShape
 		c.m_radius = radius
 		c
 	}
 	
 	def static operator_multiply(Transform t, Vec2 vec) {
 		Transform.mul(t, vec)
 	}
	
	def static operator_multiply(Vec2 v, Float f) {
 		v.mul(f)
 	}
	
}