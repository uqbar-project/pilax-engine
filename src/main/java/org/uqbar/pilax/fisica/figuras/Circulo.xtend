package org.uqbar.pilax.fisica.figuras

import org.jbox2d.dynamics.BodyDef
import org.jbox2d.dynamics.BodyType
import org.jbox2d.dynamics.FixtureDef
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.fisica.Figura
import org.uqbar.pilax.fisica.Fisica

import static extension org.uqbar.pilax.fisica.box2d.Box2DExtensions.*

//PILAX: hay codigo repetido con cuadrado. Cambia poco del uso de box2d !
class Circulo extends Figura {
	
	new(double x, double y, int radio) {
		// mal hack de casteo!
		this(x, y, radio, true, 1.0, 0.56, 10.5, 0.1, Pilas.instance.escenaActual.fisica as Fisica, false)
	} 
	
	new(double x0, double y0, int radio0, boolean dinamica, double densidad, double restitucion, double friccion, double amortiguacion, Fisica fisica, boolean sin_rotacion) {
        val x = x0.aMetros
        val y = y0.aMetros
        val radio = radio0.aMetros
        
		val fixture = new FixtureDef() => [
        	shape = CircleShape(radio)
        	userData = this.id
        	friction = friccion.floatValue
        	restitution = restitucion.floatValue
        	density = if (dinamica) 0f else densidad.floatValue
		]

        if (dinamica)
            cuerpo = fisica.mundo.createBody(new BodyDef() => [ 
            	type = BodyType.DYNAMIC 
            	position = (x -> y).asVec
            	linearDamping=amortiguacion.floatValue
            ])
        else
            this.cuerpo = fisica.mundo.createBody(new BodyDef() => [ 
            	type = BodyType.KINEMATIC 
            	position = (x -> y).asVec
            	linearDamping=amortiguacion.floatValue
//            	fixture =fixture
            ])

		cuerpo.createFixture(fixture)  // esto esta distinto a box2d de pilas
        cuerpo.fixedRotation = sin_rotacion
	}
	
}