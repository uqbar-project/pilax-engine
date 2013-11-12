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
		val ancho = areaMotor.key
		val alto = areaMotor.value
		return new Area(x.intValue - ancho / 2, x.intValue + ancho / 2, y.intValue + alto / 2, y.intValue - alto / 2)
	}
	
	def getPosicion() {
		(x.intValue -> y.intValue)
	}

	def setX(double x) {
		eventos.mueveCamara.emitir(new DataEventoMovimiento((x.floatValue -> y.floatValue), ((x - this.x).floatValue -> 0f)))
		motor.centroDeLaCamara = (x.intValue -> this.y.intValue)
	}

	def double getX() {
		motor.centroDeLaCamara.x.doubleValue
	}

	def getMotor() {
		Pilas.instance.mundo.motor
	}

	/**Define la posición vertical de la cámara.
        :param y: Posición vertical.
        */
	def setY(double y) {
		eventos.mueveCamara.emitir(new DataEventoMovimiento((this.x.floatValue -> y.floatValue), (0f -> (y - this.y).floatValue)))
		motor.centroDeLaCamara = (this.x.intValue -> y.intValue)
	}

	def double getY() {
		motor.centroDeLaCamara.y.doubleValue
	}

	/** Mueve la cámara hacia una posición en particular.
        :param posicion: La posición destino, a donde enfocar.
     */	
	def desplazar(Pair<Integer, Integer> posicion) {
        (posicion.x - x.intValue -> posicion.y - y.intValue)
	}
	
    /** Mueve la cámara a la posicion inicial (0,0). */
	def reiniciar() {
        motor.centroDeLaCamara = origen
	}
	
}
