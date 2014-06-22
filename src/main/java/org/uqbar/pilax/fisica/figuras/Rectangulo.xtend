package org.uqbar.pilax.fisica.figuras

import org.uqbar.pilax.fisica.Figura
import org.uqbar.pilax.fisica.Fisica
import org.jbox2d.dynamics.FixtureDef

import static extension org.uqbar.pilax.fisica.box2d.Box2DExtensions.*
import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*
import static extension org.uqbar.pilax.utils.Utils.*
import org.jbox2d.collision.shapes.PolygonShape
import org.jbox2d.dynamics.BodyDef
import org.jbox2d.dynamics.BodyType
import org.jbox2d.dynamics.Body

class Rectangulo extends Figura {
	
	new(double x, double y, double ancho, double alto, boolean dinamica, Fisica fisica, double restitucion) {
		this(x, y, ancho, alto, dinamica, 1.0, 0.5, 0.2, 0.1, fisica, false)
	} 
	
	new(double x0, double y0, double ancho0, double alto0, boolean dinamica, double densidad,
            double restitucion, double friccion, double amortiguacion,
            Fisica fisica, boolean sin_rotacion) {

        val x = x0.aMetros
        val y = y0.aMetros
        val ancho = ancho0.aMetros
        val alto = alto0.aMetros

		val polygon = new PolygonShape() => [ setAsBox(ancho.floatValue/2, alto.floatValue/2) ]

        val fixture = new FixtureDef() => [
        	shape = polygon
        	userData = uuid()
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
        	cuerpo = fisica.mundo.createBody(new BodyDef() => [ 
            	type = BodyType.KINEMATIC 
            	position = (x -> y).asVec
            	linearDamping=amortiguacion.floatValue
//            	fixture =fixture
            ])
		cuerpo.createFixture(fixture)  // esto esta distinto a box2d de pilas
        cuerpo.fixedRotation = sin_rotacion
	}
	
}