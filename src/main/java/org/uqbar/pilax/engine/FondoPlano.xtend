package org.uqbar.pilax.engine

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*
import static extension org.uqbar.pilax.motor.qt.QtExtensions.*

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
        val s = motor.centroDeLaCamara.x -> -motor.centroDeLaCamara.y 

        painter.drawTiledPixmap(origen, motor.area, this.imagen.imagen, s % 30)
        painter.restore
	}

}

class FondoEspacio extends Fondo {
	
	new() {
		super("fondos/espacio.jpg")
	}
	
}