package org.uqbar.pilax.engine

import com.trolltech.qt.gui.QPainter

class Fondo extends Actor {
	
	new(String imagen) {
        super(imagen, 0, 0)
		eliminarFondoActual()
        z = 1000
	}
	
	override esFondo() {
		true
	}
	
	def protected eliminarFondoActual() {
        val aEliminar = newArrayList()
        for (f : Pilas.instance.fondos) {
            aEliminar.add(f)
        }

        for (fondo : aEliminar) {
            fondo.eliminar
        }
	}
	
}

class FondoPlano extends Fondo {
	
	new() {
		super("plano.png")
	}
	
	override dibujar(QPainter painter) {
        painter.save()
        x = Pilas.instance.mundo.motor.camaraX
        y = -Pilas.instance.mundo.motor.camaraY

		val area = Pilas.instance.mundo.motor.area
        val ancho = area.key
        val alto = area.value
        
        painter.drawTiledPixmap(0, 0, ancho, alto, this.imagen.imagen, x % 30, y % 30)
        painter.restore()
	}

}