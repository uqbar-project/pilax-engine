package org.uqbar.pilax.fisica

import java.awt.Color
import java.util.List
import org.eclipse.xtext.xbase.lib.Pair
import org.jbox2d.callbacks.ContactListener
import org.jbox2d.collision.shapes.CircleShape
import org.jbox2d.collision.shapes.PolygonShape
import org.jbox2d.dynamics.Body
import org.jbox2d.dynamics.World
import org.jbox2d.pooling.normal.DefaultWorldPool
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.engine.PilaxException
import org.uqbar.pilax.fisica.box2d.Box2DExtensions
import org.uqbar.pilax.fisica.figuras.Rectangulo
import org.uqbar.pilax.motor.Lienzo
import org.uqbar.pilax.motor.qt.Motor

import static extension org.uqbar.pilax.fisica.box2d.Box2DExtensions.*
import static extension org.uqbar.pilax.utils.PilasExtensions.*
import com.trolltech.qt.gui.QPainter

class Fisica implements MotorFisica {
	static final boolean ENABLED = true
	
	/**"""Genera el motor de física Box2D.

    :param area: El area de juego.
    :param gravedad: La gravedad del escenario.
    """ */
	def static crearMotorFisica(Pair<Double, Double> area, Pair<Double,Double> gravedad) {
		//TODO PILAX completar fisica con box2d
		
	    if (ENABLED) {
	        return new Fisica(area, gravedad)
        }
	    else {
        	print("Fisica Box2D deshabilita.")
        	return new FisicaDeshabilitada
      }
	}
	
	@Property World mundo
	ContactListener objetosContactListener
	Pair<Double,Double> area
	List<Body> figuras_a_eliminar
	ConstanteDeMovimiento constante_mouse
	double velocidad
	double timeStep 
	
	Rectangulo techo
	Rectangulo suelo
	Rectangulo pared_izquierda
	Rectangulo pared_derecha

	/**
	 * Inicializa el motor de física.
     *   :param area: El area del escenario, en forma de tupla.
     *   :param gravedad: La aceleración del escenario.
     */	
	new(Pair<Double, Double> area, Pair<Double, Double> gravedad) {
        this.mundo = new World(gravedad.asVec) // new DefaultWorldPool(100, 40)) // tomado de testbed
        this.objetosContactListener = new ObjetosContactListener
        this.mundo.contactListener = this.objetosContactListener
        this.mundo.continuousPhysics = false

        this.area = area
        this.figuras_a_eliminar = newArrayList

        this.constante_mouse = null
        this.crear_bordes_del_escenario

        this.velocidad = 1.0
        this.timeStep = this.velocidad / 120.0
	}
	
	/** Genera las paredes, el techo y el suelo. */
	def crear_bordes_del_escenario() {
        crear_techo(area)
        crear_suelo(area)
        crear_paredes(area)
    }
    
    def crear_techo(Pair<Double, Double> area) {
    	crear_techo(area, 0)
    }
    
    def crear_techo(Pair<Double, Double> area, int restitucion) {
        /**Genera un techo sólido para el escenario.

        :param ancho: El ancho del techo.
        :param alto: Alto del techo.
        :param restitucion: El grado de conservación de energía ante una colisión.
        */
        this.techo = new Rectangulo(0, area.alto / 2, area.ancho, 2, false, this, restitucion)
    }
    
    def crear_suelo(Pair<Double, Double> area) {
    	crear_suelo(area, 0)
    }

    /**
     * Genera un suelo sólido para el escenario.
     *  :param ancho: El ancho del suelo.
     *  :param alto: Alto del suelo.
     *  :param restitucion: El grado de conservación de energía ante una colisión.
     */    
    def crear_suelo(Pair<Double, Double> area, int restitucion) {
        this.suelo = new Rectangulo(0, -area.alto/2, area.ancho, 2, false, this, restitucion)
    }
    
    def crear_paredes(Pair<Double, Double> area) {
    	crear_paredes(area, 0)
    }

    /** Genera dos paredes para el escenario.
        :param ancho: El ancho de las paredes.
        :param alto: El alto de las paredes.
        :param restitucion: El grado de conservación de energía ante una colisión.
     */    
    def crear_paredes(Pair<Double, Double> area, int restitucion) {
        pared_izquierda = new Rectangulo(-area.ancho/2, 0, 2, area.alto, false, this, restitucion)
        pared_derecha = new Rectangulo(area.ancho/2, 0, 2, area.alto, false, this, restitucion)
    }
    
    /** Gestiona el evento de movimiento del mouse.

        :param x: Coordenada horizontal del mouse.
        :param y: Coordenada vertical del mouse.
        */
    def cuando_mueve_el_mouse(int x, int y) {
        if (constante_mouse != null)
           constante_mouse.mover(x, y)
    }

	/** Comienza a capturar una figura con el mouse.
        :param figura: La figura a controlar con el mouse.
     */    
    def capturar_figura_con_el_mouse(Figura figura) {
        if (constante_mouse != null)
            cuando_suelta_el_mouse

        constante_mouse = new ConstanteDeMovimiento(figura)
    }
    
    /**Se ejecuta cuando se suelta el botón de mouse.*/
    def cuando_suelta_el_mouse() {
        if (constante_mouse != null)
            constante_mouse.eliminar
            constante_mouse = null
    }
    
    // *************************
    // ** MotorFisica
    // *************************
    
	override actualizar() {
		// Solo actualizamos la fisica si existen más de 4 bodies.
        // Ya que las paredes ya vienen definidas al crear la fisica.
        if (mundo.bodyCount <= 4) 
        	return;
        	
        // TODO: eliminar el arguemnto velocidad que no se utiliza.
        if (mundo != null) {
            mundo.step(timeStep.floatValue, 6, 2)
            _procesar_figuras_a_eliminar()
            mundo.clearForces
        }
	}
	
	def _procesar_figuras_a_eliminar() {
        /** Elimina las figuras que han sido marcadas para quitar.*/
        if (!figuras_a_eliminar.nullOrEmpty)
            for (x : figuras_a_eliminar) {
                // Solo elimina las figuras que actualmente existen.
                if (x.in(mundo.bodyList))
                    mundo.destroyBody(x)
            }
            figuras_a_eliminar = newArrayList
    }

	/** Elimina todos los objetos físicos y vuelve a crear el entorno. */    
    override reiniciar() {
    	mundo.bodyList.asIterable.forEach[mundo.destroyBody(it)]
        crear_bordes_del_escenario()
    }
    
	override pausarMundo() {
		if (mundo != null)
            timeStep = 0
	}
    
    /** Restaura la simulación física. */
    override reanudarMundo() {
        if (mundo != null)
            timeStep = velocidad / 120.0
    }
    
	override eliminarFigura(Figura f) {
		figuras_a_eliminar.add(f.cuerpo)
	}
	
	def dibujar_figuras_sobre_lienzo(QPainter painter, Lienzo lienzo) {
		dibujar_figuras_sobre_lienzo(painter, lienzo, 1)
	}
	
	def dibujar_figuras_sobre_lienzo(QPainter painter, Lienzo lienzo, int grosor) {
       	/** Dibuja todas las figuras en una pizarra. Indicado para depuracion.

        :param motor: Referencia al motor de pilas.
        :param lienzo: Un actor lienzo sobre el que se dibujará.
        :param grosor: El grosor de la linea medida en pixels.
        */

        for (cuerpo : mundo.bodyList.asIterable) {
            for (fixture : cuerpo.fixtureList.asIterable) {

                // cuerpo.type == 0 → estatico
               	// cuerpo.type == 1 → kinematico
                // cuerpo.type == 2 → dinamico

                val shape = fixture.shape

                if (shape instanceof PolygonShape) {
                	var vertices = (shape as PolygonShape).vertices.map[v| 
                		cuerpo.transform * v * Box2DExtensions.PPM
                	]
                    var ver = vertices.map[v | Pilas.instance.escenaActual.camara.desplazar(v.asPair)]
                    lienzo.poligono(painter, ver, Color.white, grosor, true)
                }
                else if (shape instanceof CircleShape) {
                    val xy = pilas.escenaActual.camara.desplazar((cuerpo.transform * (shape as CircleShape).m_p * PPM).asPair)
                    lienzo.circulo(painter, xy.x.intValue, xy.y.intValue, (shape.radius * PPM).intValue, Color.white, grosor)
                }
                else
                    // TODO: implementar las figuras de tipo "edge" y "loop".
                    throw new PilaxException("No puedo identificar el tipo de figura.")
            }
        }
	}
	
	def cantidad_de_cuerpos() {
        mundo.bodyCount
    }
    
}