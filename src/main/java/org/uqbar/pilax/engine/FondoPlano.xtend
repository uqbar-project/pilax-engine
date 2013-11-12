package org.uqbar.pilax.engine

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

import com.trolltech.qt.gui.QPainter

class Fondo extends Actor {
	
	new(String imagen) {
        super(imagen, 0, 0)
		eliminarFondosAnteriores
        z = 1000
	}
	
	override esFondo() {
		true
	}
	
	def protected eliminarFondosAnteriores() {
		Pilas.instance.fondos.copy.forEach[ if (it != this) eliminar]
	}
	
}

class FondoPlano extends Fondo {
	
	new() {
		super("plano.png")
	}
	
	override dibujar(QPainter painter) {
        painter.save()
        x = motor.centroDeLaCamara.x.doubleValue
        y = - motor.centroDeLaCamara.y

        painter.drawTiledPixmap(0, 0, motor.area.ancho, motor.area.alto, this.imagen.imagen, x.intValue % 30, y.intValue % 30)
        painter.restore
	}

}

class FondoEspacio extends Fondo {
	
	new() {
		super("fondos/espacio.jpg")
	}
	
}