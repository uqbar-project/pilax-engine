package org.uqbar.pilax.engine.motor

import static extension org.uqbar.pilax.engine.PilasExtensions.*
import com.trolltech.qt.gui.QPainter
import com.trolltech.qt.gui.QPixmap
import org.uqbar.pilax.engine.Pilas

import static extension org.uqbar.pilax.engine.PythonUtils.*

class ActorBaseMotor {
	@Property int x
	@Property int y
	
	@Property int rotacion = 0
	@Property int transparencia = 0
    @Property int centro_x = 0
    @Property int centro_y = 0
	@Property int escala_x = 1
    @Property int escala_y = 1
	@Property boolean espejado = false
    @Property int fijo = 0
    
    new(int x, int y) {
    	this.x = x
		this.y = y
    }
	
	def setCentro(Pair<Integer, Integer> centro) {
        self.centro_x = centro.key
        self.centro_y = centro.value
    }
    
    def getCentro() {
    	self.centro_x -> self.centro_y
    }

    def getPosicion() {
        self.x -> self.y
    }

    def setPosicion(Pair<Integer, Integer> posicion) {
        self.x = posicion.key
        self.y = posicion.value
    }

    def getEscala() {
        self._escala_x
    }

    def setEscala(int s) {
        self._escala_x = s
        self._escala_y = s
    }

}

class ActorMotor extends ActorBaseMotor {
	@Property ImagenMotor imagen
	
	new(String imagen, int x, int y) {
		super(x,y)
		this.imagen = cargarImagen(imagen)
	}
	
	def ImagenMotor cargarImagen(String path) {
		// probablemente habria que delegar en el motor
		new ImagenMotor(path)
	}

    def dibujar(QPainter painter) {
        var escala_x = self.escala_x
        var escala_y = self.escala_y

        if (self.espejado) 
            escala_x = escala_x * -1

		var int dx
		var int dy
		
        if (self.fijo == 0) {
            dx = Pilas.instance.mundo.motor.camaraX
            dy = Pilas.instance.mundo.motor.camaraY
        }
        else {
            dx = 0
            dy = 0
		}
		
        x = self.x - dx
        y = self.y - dy

        self.imagen.dibujar(painter, x, y, self.centro_x, self.centro_y, escala_x, escala_y, self.rotacion, self.transparencia)
    }
	
}

class ImagenMotor {
	@Property QPixmap imagen
	private String ruta
	
	new(String path) {
		ruta = path.resolveFullPathFromClassPath
		if (ruta.toLowerCase.endsWith("jpeg") || ruta.toLowerCase.endsWith("jpg")) {
           self.imagen = self.cargarJpeg(ruta)
        }
        else {
            self.imagen = new QPixmap(ruta)
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
    def void dibujar(QPainter painter, int x, int y, int dx /*=0*/, int dy /*=0*/, int escala_x /*=1*/ , int escala_y /*=1*/, int rotacion /*=0*/, int transparencia /*=0*/) {
        painter.save()
        val centro = Pilas.instance.mundo.motor.centroFisico
        
        painter.translate(x + centro.key, centro.value - y)
        painter.rotate(rotacion)
        painter.scale(escala_x, escala_y)

        if (transparencia != 0) 
            painter.setOpacity(1 - transparencia/100.0)

        self.dibujarPixmap(painter, -dx, -dy)
        painter.restore
	}
	
	def private dibujarPixmap(QPainter painter, int x, int y) {
        painter.drawPixmap(x, y, self.imagen)
    }
    
    def ancho() {
        self.imagen.size.width
    }

    def alto() {
        self.imagen.size.height
    }

   	/* Retorna una tupla con la coordenada del punto medio del la imagen. */
    def centro() {
        self.ancho / 2 -> self.alto / 2
    }

    def avanzar() {
    }
	
}