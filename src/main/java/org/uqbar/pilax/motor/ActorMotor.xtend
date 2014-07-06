package org.uqbar.pilax.motor

import org.uqbar.pilax.engine.Pilas

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class ActorBaseMotor {
	@Property Pair<Double,Double> posicion = origen
	@Property Pair<Double, Double> centro
	@Property Pair<Double, Double> escalas = (1.0 -> 1.0) 
	@Property double rotacion = 0
	@Property double transparencia = 0
	@Property boolean espejado = false
    @Property boolean fijo = false
    
    new(double x, double y) {
    	this.posicion = x -> y
    }
	
    def setPosicion(Pair<Double, Double> posicion) {
    	_posicion = posicion
    }
    
    def getX() {
    	posicion.x
    }
    
    def void setX(double x) {
    	posicion = x -> this.y
    }
    
    def void setY(double y) {
    	posicion = this.x -> y
    }
    
    def getY() {
    	posicion.y
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
	
	new(ImagenMotor imagen, double x, double y) {
		super(x,y)
		this.imagen = imagen
	}

    def dibujar(PilasPainter painter) {
        var escala_x = escalas.x

        if (espejado) 
            escala_x = escala_x * -1

		var Pair<Double,Double> delta = if (this.fijo)
        										motor.centroDeLaCamara
											else
        										origen
		
        val x = posicion.x - delta.x
        val y = posicion.y - delta.y

        imagen.dibujar(painter, x, y, centro.x, centro.y, escala_x, escalas.y, this.rotacion.intValue, transparencia)
    }
    
    def void setImagen(ImagenMotor imagen) {
    	// permite que varios actores usen la misma grilla.
    	// PILAX!
//        if (imagen instanceof Grilla)
//          imagen = copy.copy(imagen)
//        else:
            _imagen = imagen
    }
	
}

class ImagenMotor {
	@Property PilasImage imagen
	@Property String ruta
	
	new() {
		//hack para la subclase Texto ?
	}
	
	new(String path) {
		ruta = path.resolveFullPathFromClassPath
		_imagen = motor.loadImage(ruta)
	}
	
	new (PilasImage imagen) {
		_imagen = imagen
	}
	
	/**
	 * Dibuja la imagen sobre la ventana que muestra el motor.
	 *  x, y: indican la posicion dentro del mundo.
	 *  dx, dy: es el punto centro de la imagen (importante para rotaciones).
	 *  escala_x, escala_yindican cambio de tamano (1 significa normal).
	 *  rotacion: angulo de inclinacion en sentido de las agujas del reloj.
	 *
	 */    
    def void dibujar(PilasPainter painter, double x, double y, double dx, double dy, double escala_x, double escala_y, double rotacion, double transparencia) {
        painter => [
        	save
        	val centro = motor.centroFisico
	        translate(x + centro.x, centro.y - y)
	        rotate(rotacion)
	        scale(escala_x, escala_y)
	        if (transparencia != 0) { 
	            opacity = 1 - transparencia / 100.0
	        }
	    ]
        dibujarPixmap(painter, -dx, -dy)
        painter.restore
	}

	def getMotor() { mundo.motor }
	def getMundo() { Pilas.instance.mundo }
	
	def protected dibujarPixmap(PilasPainter painter, double x, double y) {
        painter.drawPixmap(x.intValue, y.intValue, imagen)
    }
    
    def getAncho() { imagen.width }
    def void setAncho(double ancho) { imagen.width = ancho }
    def getAlto() { imagen.height }
    
   	/* Retorna una tupla con la coordenada del punto medio del la imagen. */
    def getCentro() {
        ancho / 2 -> alto / 2
    }

    def boolean avanzar() { false }
	
}