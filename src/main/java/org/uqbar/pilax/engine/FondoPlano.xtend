package org.uqbar.pilax.engine

import org.uqbar.pilax.motor.PilasPainter

import static extension org.uqbar.pilax.utils.PilasExtensions.*

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
	
	override dibujar(PilasPainter painter) {
        val s = motor.centroDeLaCamara.x -> -motor.centroDeLaCamara.y 
		painter.drawTiledPixmap(origen, motor.area, this.imagen.imagen, s % 30)
	}

}

class FondoEspacio extends Fondo {
	
	new() {
		super("fondos/espacio.jpg")
	}
	
}