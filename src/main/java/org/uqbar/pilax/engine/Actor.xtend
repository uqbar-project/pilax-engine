package org.uqbar.pilax.engine

import static extension org.uqbar.pilax.engine.PythonUtils.*
import java.util.List
import org.uqbar.pilax.engine.motor.ActorMotor
import com.trolltech.qt.gui.QPainter
import org.uqbar.pilax.engine.motor.ImagenMotor

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
		actorMotor = Pilas.instance.mundo.motor.obtenerActor(imagen, x, y)
		Pilas.instance.escenaActual.agregarActor(this)
        dx = x
        dy = y
        centro = centroDeImagen
	}
	
	def centroDeImagen() {
		(ancho / 2 -> alto / 2)
	}
	
	def getX() {
		this.actorMotor.x
	}
	
	def void setX(int x) {
		this.actorMotor.x = x
	}
	
	def getY() {
		this.actorMotor.y
	}
	
	def void setY(int y) {
		this.actorMotor.y = y
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
		this.actorMotor.dibujar(aplicacion)
	}
	/** Indica si el actor está fuera del area visible de la pantalla.*/
	def estaFueraDeLaPantalla() {
        if (self.fijo) {
            return false
        }
        val areaVisible = self.escena.camara.areaVisible
        return self.derecha < areaVisible.izquierda ||
        		self.izquierda > areaVisible.derecha ||
        		self.abajo > areaVisible.arriba || self.arriba < areaVisible.abajo
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
        return x - (centro.key * escala)
    }

    def setIzquierda(int x) {
        self.x = x + (self.centro.key * self.escala)
    }
    
    def getDerecha() {
        self.izquierda + self.ancho * self.escala
    }
	
	def setDerecha(int x) {
        self.setIzquierda(x - self.ancho)
    }
    
    def getAncho() {
    	imagen.ancho
    }
    
    def getAlto() {
    	imagen.alto
    }
    
    def getArriba() {
    	return self.y + (self.centro.value * self.escala)
    }
    
    def setArriba(int y) {
        self.y = y - (self.centro.value * self.escala)
    }
    
    def setAbajo(int y) {
        self.setArriba(y + self.alto)
    }
    
    def getAbajo() {
        return self.arriba - self.alto * self.escala
    }
	
	/** Actualiza comportamiento y habilidades antes de la actualización.
        También actualiza la velocidad horizontal y vertical que lleva el actor.
        */
	def preActualizar() {
        self.actualizarComportamientos
        self.actualizarHabilidades
        self.actualizarVelocidad
	}
	
	def actualizar() {
		pass
	}

	/** """ Calcula la velocidad horizontal y vertical del actor. """ */	
	def protected actualizarVelocidad() {
        if (self.dx != self.x) {
            self._vx = Math.abs(self._dx - self.x)
            self._dx = self.x
        }
        else
            self._vx = 0

        if (self._dy != self.y) {
            self._vy = Math.abs(self._dy - self.y)
            self._dy = self.y
        }
        else
            self._vy = 0
	}
    
}