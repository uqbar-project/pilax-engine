package org.uqbar.pilax.motor

import com.trolltech.qt.gui.QPainter
import com.trolltech.qt.gui.QPixmap
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.engine.Pilas

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

class ActorBaseMotor {
	@Property int x
	@Property int y
	
	@Property double rotacion = 0
	@Property double transparencia = 0
	@Property Pair<Integer, Integer> centro
	@Property Pair<Double, Double> escalas = (1.0 -> 1.0)
	@Property boolean espejado = false
    @Property int fijo = 0
    
    new(int x, int y) {
    	this.x = x
		this.y = y
    }
	
    def getPosicion() {
        x -> y
    }

    def setPosicion(Pair<Integer, Integer> posicion) {
        x = posicion.key
        y = posicion.value
    }
    
    // sospecho que algo esta mal aca
    // esto solo se usa cuando implicitamente trabajas con 
    // una escala igual para 'x' que para 'y'
    def getEscala() {
    	escalas.x
    }

    def void setEscala(Double s) {
    	_escalas = s.asPair
	}

}

class ActorMotor extends ActorBaseMotor {
	@Property ImagenMotor imagen
	
	new(ImagenMotor imagen, int x, int y) {
		super(x,y)
		this.imagen = imagen
	}

    def dibujar(QPainter painter) {
        var escala_x = escalas.x

        if (espejado) 
            escala_x = escala_x * -1

		var Pair<Integer,Integer> delta = if (this.fijo == 0)
        										motor.centroDeLaCamara
											else
        										origen
		
        val x = this.x - delta.x
        val y = this.y - delta.y

        imagen.dibujar(painter, x, y, centro.x, centro.y, escala_x, escalas.y, this.rotacion.intValue, transparencia)
    }
    
    def void setImagen(ImagenMotor imagen) {
    	// permite que varios actores usen la misma grilla.
    	// PILAX!
//        if (imagen instanceof Grilla)
//            self._imagen = copy.copy(imagen)
//        else:
            self._imagen = imagen
    }
	
}

class ImagenMotor {
	@Property QPixmap imagen
	@Property String ruta
	
	new() {
		//hack para la subclase Texto ?
	}
	
	new(String path) {
		ruta = path.resolveFullPathFromClassPath
		if (ruta.toLowerCase.endsWith("jpeg") || ruta.toLowerCase.endsWith("jpg")) {
           imagen = cargarJpeg(ruta)
        }
        else {
            imagen = new QPixmap(ruta)
        }
	}
	
	def QPixmap cargarJpeg(String ruta) {
		throw new UnsupportedOperationException("Needs to implement support for jpg")
		
		// seems like it converts the jpeg into png
		
//        val pilImage = Image.open(ruta)
//        val stringIO = new StringIO()
//        pilImage.save(stringIO, "png")
//        val pixmapImage = new QPixmap()
//        pixmapImage.loadFromData(stringIO.getvalue())
//        pixmapImage
	}
	
	/**
	 * Dibuja la imagen sobre la ventana que muestra el motor.
	 *  x, y: indican la posicion dentro del mundo.
	 *  dx, dy: es el punto centro de la imagen (importante para rotaciones).
	 *  escala_x, escala_yindican cambio de tamano (1 significa normal).
	 *  rotacion: angulo de inclinacion en sentido de las agujas del reloj.
	 *
	 */    
    def void dibujar(QPainter painter, int x, int y, int dx, int dy, double escala_x, double escala_y, int rotacion, double transparencia) {
        painter => [
        	save
        	val centro = motor.centroFisico
	        translate(x + centro.key, centro.value - y)
	        rotate(rotacion)
	        scale(escala_x, escala_y)
	        if (transparencia != 0) { 
	            opacity = 1 - transparencia / 100.0
	        }
	    ]
        dibujarPixmap(painter, -dx, -dy)
        painter.restore
	}

	def getMotor() {
		mundo.motor
	}
	
	def getMundo() {
		Pilas.instance.mundo
	}
	
	def protected dibujarPixmap(QPainter painter, int x, int y) {
        painter.drawPixmap(x, y, imagen)
    }
    
    def getAncho() {
        imagen.size.width
    }

    def getAlto() {
        imagen.size.height
    }

   	/* Retorna una tupla con la coordenada del punto medio del la imagen. */
    def getCentro() {
        ancho / 2 -> alto / 2
    }

    def boolean avanzar() {
    	false 
    }
	
}