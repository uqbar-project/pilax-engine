package org.uqbar.pilax.engine

import com.trolltech.qt.gui.QPainter
import java.util.List
import java.util.UUID
import org.eclipse.xtext.xbase.lib.Pair
import org.eclipse.xtext.xbase.lib.Procedures.Procedure0
import org.eclipse.xtext.xbase.lib.Procedures.Procedure2
import org.uqbar.pilax.actores.ActorGlobo
import org.uqbar.pilax.actores.PosicionCentro
import org.uqbar.pilax.comunes.ObjetoGrafico
import org.uqbar.pilax.habilidades.Imitar
import org.uqbar.pilax.motor.ActorMotor
import org.uqbar.pilax.motor.ImagenMotor

import static extension org.uqbar.pilax.utils.PilasExtensions.*

/**
 * 
 */
class Actor extends Estudiante implements ObjetoGrafico {
	@Property UUID id
	boolean vivo = true
	List<Actor> anexados = newArrayList
	@Property int z = 0
	protected ActorMotor actorMotor
	@Property EscenaBase escena
	@Property int radioDeColision = 10
	@Property Pair<Integer,Integer> velocidad = origen
	@Property Pair<Integer,Integer> delta = origen
	// velocidad
	@Property boolean fijo
	@Property Pair<Integer, Integer> centro
	// cosas raras
	@Property Object figura
	
	new(String imagen, int x, int y) {
		this(Pilas.instance.mundo.motor.cargarImagen(imagen), x, y)
	}
	
	new(ImagenMotor imagen) {
		this(imagen, 0, 0)
	}
	
	new(ImagenMotor imagen, int x, int y) {
		id = uuid()
		actorMotor = crearActorMotor(imagen, x, y)
		Pilas.instance.escenaActual.agregarActor(this)
		delta = x -> y
        centro = centroDeImagen
	}
	
	def static getMotor() {
		Pilas.instance.mundo.motor
	}
	
	/** Sobrescribir para crear otro actor de motor */
	def protected crearActorMotor(ImagenMotor imagen, int x, int y) {
		motor.crearActor(imagen, x, y)
	}
	
	def void setCentroRelativo(Pair<PosicionCentro, PosicionCentro> posicionCentro) {
		centro = posicionCentro.x.interpretar(ancho) -> posicionCentro.x.interpretar(alto) 
	}
	
	def centroDeImagen() {
		(ancho / 2 -> alto / 2)
	}
	
	def getPosicion() {
		(x -> y)
	}
	
	def getPosicionCamara() {
		escena.camara.posicion
	}
	
	def getPosicionRelativaACamara() {
		val centroReferencia = if (fijo) origen else posicionCamara 
        return posicion.asFloat - centroReferencia 
	}
	
	override getX() {
		// REVIEW: double para interpolar
		actorMotor.x.doubleValue
	}
	
	def void setX(double x) {
		// REVIEW: double para interpolar
		actorMotor.x = x.intValue
	}
	
	def void setPosicion(int x, int y) {
        /** Define la posición del Actor en el mundo.

        :param x: Posición horizontal del Actor en el mundo.
        :type x: int
        :param y: Posición vertical del Actor en el mundo.
        :type y: int
        */
        actorMotor.setPosicion = x -> y
	}
	
	override getY() {
		actorMotor.y.doubleValue
	}
	
	def void setY(double y) {
		actorMotor.y = y.intValue
	}
	
	def void setCentro(Pair<Integer,Integer> centro) {
		_centro = centro
        actorMotor.centro = centro
	}
	
	def getImagen() {
		actorMotor.imagen
	}
	
	def void setImagen(ImagenMotor imagen) {
        actorMotor.imagen = imagen
        centro = centroDeImagen
	}
	
	def esFondo() {
		false
	}
	
	def void eliminar() {
		// provisional hasta hacer una active annotation !
		notify([l,c| l.eliminar(this, c)],[| 
			eliminarAnexados 
			destruir
		])
	}
	
	List<ActorListener> listeners = newArrayList
	
	def addListener(ActorListener l) {
		listeners.add(l)
	}
	
	def notify(Procedure2<ActorListener, EventChain> notification, Procedure0 realTask) {
		new EventChainImpl(listeners.iterator, notification, realTask).proceed(this)
	}
	
	/** Elimina a un actor pero de manera inmediata.*/
	def destruir() {
        vivo = false
        eliminarHabilidades
        eliminarComportamientos
        // Solo permite eliminar el actor si está en su escena.
        if (actoresDeEscena.contains(this)) {
            actoresDeEscena.remove(this)
        }
	}

	def getActoresDeEscena() {
		Pilas.instance.escenaActual.actores
	}
	
	def protected eliminarAnexados() {
		anexados.forEach[it.eliminar]
	}
	
	def dibujar(QPainter aplicacion) {
		actorMotor.dibujar(aplicacion)
	}
	/** Indica si el actor está fuera del area visible de la pantalla.*/
	def estaFueraDeLaPantalla() {
        if (fijo) {
            return false
        }
        val areaVisible = escena.camara.areaVisible
        return derecha < areaVisible.izquierda ||
        		izquierda > areaVisible.derecha ||
        		abajo > areaVisible.arriba || 
        		arriba < areaVisible.abajo
	}
	
    override getRotacion() {
    	actorMotor.rotacion
    }
    
    def void setRotacion(double rotacion) {
    	actorMotor.rotacion = rotacion
    }
    
    def void setTransparencia(double transparencia) {
    	actorMotor.transparencia = transparencia
    }
    
    def getTransparencia() {
    	actorMotor.transparencia
    }
    
    def getIzquierda() {
        x - (centro.x * escala)
    }

    def setIzquierda(int x) {
        this.x = (x + centro.x * escala).intValue
    }
    
    def getDerecha() {
        izquierda + ancho * escala
    }
	
	def setDerecha(int x) {
        izquierda = x - ancho
    }
    
    def getAncho() {
    	imagen.ancho
    }
    
    def getAlto() {
    	imagen.alto
    }
    
    def getArriba() {
    	y + centro.y * escala
    }
    
    def setArriba(int y) {
        this.y = (y - centro.y * escala).intValue
    }
    
    def setAbajo(int y) {
        arriba = y + alto
    }
    
    def getAbajo() {
        return arriba - alto * escala
    }
    
    def getEscala() {
    	actorMotor.escala
    }
    
    def void setEscala(Double esc) {
        // Se hace la siguiente regla de 3 simple:
        //
        //  ultima_escala          self.radio_de_colision
        //  s                      ?
		var s = Math.max(esc, 0.001)
        val ultima_escala = escala
        actorMotor.escala  = s
        radioDeColision = ((s * radioDeColision) / Math.max(ultima_escala, 0.0001)).intValue
    }
	
	/** 
	 * Actualiza comportamiento y habilidades antes de la actualización.
     * También actualiza la velocidad horizontal y vertical que lleva el actor.
     */
	def void preActualizar() {
        actualizarComportamientos
        actualizarHabilidades
        actualizarVelocidad
	}
	
	def void actualizar() {
	}

	/** 
	 * Calcula la velocidad horizontal y vertical del actor.
	 */	
	def protected actualizarVelocidad() {
		velocidad = Math.abs(delta.x - x).intValue  -> Math.abs(delta.y - y).intValue
		delta = x.intValue -> y.intValue 
	}
	
	def decir(String mensaje) {
		decir(mensaje, true)
	}

	/**Emite un mensaje usando un globo similar al de los comics.

        :param mensaje: Texto a mostrar en el mensaje.
        :type mensaje: string
        :param autoeliminar: Establece si se eliminará el globo al cabo de unos segundos.
        :type autoeliminar: boolean
        */	
	def decir(String mensaje, boolean autoeliminar) {
        val Actor globo = new ActorGlobo(mensaje, x.intValue, y.intValue, autoeliminar)
        globo.imitar(this)
        globo.z = z - 1
        anexar(globo)
//        pilas.atajos.leer(mensaje)
	}

        /** Agrega un Actor a la lista de actores anexados al Actor actual.
        Cuando se elimina un Actor, se eliminan los actores anexados.

        :param otro_actor: Actor a anexar.
        :type otro_actor: `Actor`
         */	
    def anexar(Actor otro) {
        anexados.add(otro)
	}

	/** Hace que un Actor copie la posición y la rotación de otro Actor o
        Figura fisica.

        Por ejemplo:

        >>> circulo_dinamico = pilas.fisica.Circulo(10, 200, 50)
        >>> mi_actor.imitar(circulo_dinamico)

        :param otro_actor_o_figura: Actor o Figura física a imitar.
        :type otro_actor_o_figura: `Actor`, `Figura`
     */	
	def imitar(Actor otro) {
        aprender(Imitar) => [ objetoAImitar = otro ]
	}
	
	def colisionaConPunto(Pair<Float,Float> punto) {
		colisionaConPunto(punto.x.intValue, punto.y.intValue)
	}
	
	/** Determina si un punto colisiona con el area del actor.

       Todos los actores tienen un area rectangular, pulsa la
       tecla **F10** para ver el area de colision.

       :param x: Posición horizontal del punto.
       :type x: int
       :param y: Posición vertical del punto.
       :type y: int
     */	
	def colisionaConPunto(int x, int y) {
        return izquierda <= x  && x <= derecha && abajo <= y && abajo <= arriba
	}
}