package org.uqbar.pilax.engine

import com.trolltech.qt.gui.QPainter
import java.util.List
import java.util.UUID
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.actores.ActorGlobo
import org.uqbar.pilax.actores.PosicionCentro
import org.uqbar.pilax.comunes.ObjetoGrafico
import org.uqbar.pilax.habilidades.Imitar
import org.uqbar.pilax.motor.ActorMotor
import org.uqbar.pilax.motor.ImagenMotor

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

/**
 * 
 */
class Actor extends Estudiante implements ObjetoGrafico {
	@Property UUID id
	boolean vivo = true
	List<Actor> anexados = newArrayList
	@Property int z = 0
	private ActorMotor actorMotor
	@Property EscenaBase escena
	int transparencia = 0
	boolean espejado = false
	@Property int radioDeColision = 10
	@Property int vx = 0
	@Property int vy = 0
	@Property int dx
	@Property int dy
	// velocidad
	@Property boolean fijo
	@Property Pair<Integer, Integer> centro
	// cosas raras
	@Property Object figura
	
	new(String imagen, int x, int y) {
		this(Pilas.instance.mundo.motor.cargarImagen(imagen), x, y)
	}
	
	new(ImagenMotor imagen, int x, int y) {
		id = uuid()
		actorMotor = crearActorMotor(imagen, x, y)
		Pilas.instance.escenaActual.agregarActor(this)
        dx = x
        dy = y
        centro = centroDeImagen
	}
	
	def getMotor() {
		Pilas.instance.mundo.motor
	}
	
	/** Sobrescribir para crear otro actor de motor */
	def protected crearActorMotor(ImagenMotor imagen, int x, int y) {
		Pilas.instance.mundo.motor.obtenerActor(imagen, x, y)
	}
	
	def void setCentroRelativo(Pair<PosicionCentro, PosicionCentro> posicionCentro) {
		centro = posicionCentro.x.interpretar(ancho) -> posicionCentro.x.interpretar(alto) 
	}
	
	def centroDeImagen() {
		(ancho / 2 -> alto / 2)
	}
	
	override getX() {
		// REVIEW: double para interpolar
		actorMotor.x.doubleValue
	}
	
	def void setX(double x) {
		// REVIEW: double para interpolar
		actorMotor.x = x.intValue
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
		eliminarAnexados
        destruir
	}
	
	/** Elimina a un actor pero de manera inmediata.*/
	def destruir() {
        vivo = false
        eliminarHabilidades
        eliminarComportamientos
        // Solo permite eliminar el actor si está en su escena.
        if (Pilas.instance.escenaActual.actores.contains(this)) {
            Pilas.instance.escenaActual.actores.remove(this)
        }
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
        val areaVisible = self.escena.camara.areaVisible
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
    
    def getIzquierda() {
        x - (centro.x * escala)
    }

    def setIzquierda(int x) {
        this.x = (x + (centro.x * escala)).intValue
    }
    
    def getDerecha() {
        izquierda + ancho * escala
    }
	
	def setDerecha(int x) {
        setIzquierda(x - ancho)
    }
    
    def getAncho() {
    	imagen.ancho
    }
    
    def getAlto() {
    	imagen.alto
    }
    
    def getArriba() {
    	return y + (centro.y * escala)
    }
    
    def setArriba(int y) {
        this.y = (y - (centro.y * escala)).intValue
    }
    
    def setAbajo(int y) {
        setArriba(y + alto)
    }
    
    def getAbajo() {
        return arriba - alto * escala
    }
    
    def getEscala() {
    	actorMotor.escala
    }
    
    def void setEscala(double esc) {
    	var s = esc
    	if (esc < 0.001)
            s = 0.001

        val ultima_escala = escala

        // Se hace la siguiente regla de 3 simple:
        //
        //  ultima_escala          self.radio_de_colision
        //  s                      ?

        actorMotor.escala = s
        radioDeColision = ((s * radioDeColision) / Math.max(ultima_escala, 0.0001)).intValue
    }
	
	/** 
	 * Actualiza comportamiento y habilidades antes de la actualización.
     * También actualiza la velocidad horizontal y vertical que lleva el actor.
     */
	def preActualizar() {
        actualizarComportamientos
        actualizarHabilidades
        actualizarVelocidad
	}
	
	def actualizar() {
		pass
	}

	/** 
	 * Calcula la velocidad horizontal y vertical del actor.
	 */	
	def protected actualizarVelocidad() {
        if (dx != x) {
            _vx = Math.abs(_dx - x).intValue  // intValue por tener forzado a double para interpolaciones
            _dx = x.intValue
        }
        else
            _vx = 0

        if (_dy != y) {
            _vy = Math.abs(_dy - y).intValue
            _dy = y.intValue
        }
        else
            _vy = 0
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
}