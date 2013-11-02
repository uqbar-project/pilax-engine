package org.uqbar.pilax.engine

import static extension org.uqbar.pilax.engine.PilasExtensions.*
import static extension org.uqbar.pilax.engine.PythonUtils.*
import java.util.List
import org.uqbar.pilax.engine.motor.ActorMotor
import com.trolltech.qt.gui.QPainter
import org.uqbar.pilax.engine.motor.ImagenMotor

/**
 * 
 */
class Actor extends Estudiante {
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
	
	new(String imagen, int x, int y) {
		this(Pilas.instance.mundo.motor.cargarImagen(imagen), x, y)
	}
	
	new(ImagenMotor imagen, int x, int y) {
		actorMotor = crearActorMotor(imagen, x, y)
		Pilas.instance.escenaActual.agregarActor(this)
        dx = x
        dy = y
        centro = centroDeImagen
	}
	
	/** Sobrescribir para crear otro actor de motor */
	def protected crearActorMotor(ImagenMotor imagen, int x, int y) {
		Pilas.instance.mundo.motor.obtenerActor(imagen, x, y)
	}
	
	def centroDeImagen() {
		(ancho / 2 -> alto / 2)
	}
	
	def getX() {
		actorMotor.x
	}
	
	def void setX(int x) {
		actorMotor.x = x
	}
	
	def getY() {
		actorMotor.y
	}
	
	def void setY(int y) {
		actorMotor.y = y
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
	
    def getEscala() {
    	actorMotor.escala
    }
    
    def getRotacion() {
    	actorMotor.rotacion
    }
    
    def void setRotacion(int rotacion) {
    	actorMotor.rotacion = rotacion
    }
    
    def getIzquierda() {
        x - (centro.x * escala)
    }

    def setIzquierda(int x) {
        this.x = x + (centro.x * escala)
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
        this.y = y - (centro.y * escala)
    }
    
    def setAbajo(int y) {
        setArriba(y + alto)
    }
    
    def getAbajo() {
        return arriba - alto * escala
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
            _vx = Math.abs(_dx - x)
            _dx = x
        }
        else
            _vx = 0

        if (_dy != y) {
            _vy = Math.abs(_dy - y)
            _dy = y
        }
        else
            _vy = 0
	}
    
}