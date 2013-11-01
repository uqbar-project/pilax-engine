package org.uqbar.pilax.engine

import static extension org.uqbar.pilax.engine.PythonUtils.*

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
        	return new Area(self.x - ancho/2, self.x + ancho/2, self.y + alto/2, self.y - alto/2)
        }
        
        def setX(int x) {
        	Pilas.instance.escenaActual.mueveCamara.emitir(new DataEventoMovimiento(x.floatValue, self.y.floatValue, (x - self.x).floatValue, 0f))
        	Pilas.instance.mundo.motor.centroDeLaCamara = (x -> self.y)
        }
        
        def getX() {
        	Pilas.instance.mundo.motor.centroDeLaCamara.key
		}
		
		/**Define la posición vertical de la cámara.

        :param y: Posición vertical.
        */
	    def setY(int y) {
	        Pilas.instance.escenaActual.mueveCamara.emitir(new DataEventoMovimiento(self.x.floatValue, y.floatValue, 0f, (y - self.y).floatValue))
    	    Pilas.instance.mundo.motor.centroDeLaCamara = (self.x -> y)
    	}

	    def getY() {
        	Pilas.instance.mundo.motor.centroDeLaCamara.value
     	}
	
}