package org.uqbar.pilax.engine

import org.uqbar.pilax.eventos.DataEventoMovimiento
import org.uqbar.pilax.geom.Area

import static extension org.uqbar.pilax.utils.PythonUtils.*
import static extension org.uqbar.pilax.utils.Utils.*
import static extension org.uqbar.pilax.utils.PilasExtensions.*

class Camara {
	EscenaBase escena

	new(EscenaBase escena) {
		this.escena = escena
	}

	/** Retorna el area del escenario que está visible por la cámara.

        Por ejemplo, si la cámara está en posición inicial, esta
        función podría retornar:

            >>> pilas.escena_actual().camara.obtener_area_visible()
            (0, 640, 240, -240)

        y si movemos la cámara un poco para la derecha:

            >>> pilas.escena_actual().camara.x = 100
            >>> pilas.escena_actual().camara.obtener_area_visible()
            (100, 740, 240, -240)

        Es decir, la tupla representa un rectángulo de la forma::

            (izquierda, derecha, arriba, abajo)

        En nuestro caso, el último ejemplo muestra que cuando
        la cámara se mueve a ``x = 100`` el area de pantalla
        visible es ``(izquierda=100, derecha=740, arriba=240, abajo=-240)``.
        ¡ ha quedado invisible todo lo que está a la izquierda de ``x=100`` !

        Esta función es útil para ``despetar`` actores o simplemente


        Si quieres saber si un actor está fuera de la pantalla hay un
        atajo, existe un método llamado ``esta_fuera_de_la_pantalla`` en
        los propios actores:

            >>> mi_actor = pilas.actores.Mono(x=0, y=0)
            >>> mi_actor.esta_fuera_de_la_pantalla()
            False
            >>> pilas.escena_actual().camara.x == 900
            >>> mi_actor.esta_fuera_de_la_pantalla()
            True
        */
	def getAreaVisible() {
		val areaMotor = Pilas.instance.mundo.motor.area
		val ancho = areaMotor.ancho
		val alto = areaMotor.alto
		return new Area(x - ancho / 2, x + ancho / 2, y + alto / 2, y - alto / 2)
	}
	
	def getPosicion() {
		x -> y
	}
	
	def void setPosicion(Pair<Double,Double> p) {
		eventos.mueveCamara.emitir(new DataEventoMovimiento(p, p - this.posicion))
		motor.centroDeLaCamara = p
	}

	def setX(double x) {
		posicion = x -> this.y
	}
	
	def setY(double y) {
		posicion = this.x -> y
	}

	def double getX() {
		motor.centroDeLaCamara.x
	}

	def getMotor() {
		Pilas.instance.mundo.motor
	}

	def double getY() {
		motor.centroDeLaCamara.y
	}

	/** Mueve la cámara hacia una posición en particular.
        :param posicion: La posición destino, a donde enfocar.
     */	
	def desplazar(Pair<Double, Double> posicion) {
        (posicion.x - x -> posicion.y - y)
	}
	
    /** Mueve la cámara a la posicion inicial (0,0). */
	def reiniciar() {
        motor.centroDeLaCamara = origen
	}
	
}
