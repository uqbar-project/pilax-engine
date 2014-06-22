package org.uqbar.pilax.habilidades.disparar

class BalaDoble extends Municion {
	int separacion = 10
	
	new() {
	}
	
	new(int separacion) {
		this.separacion = separacion
	}
	
	override disparar(double x, double y, double rotacion, double angulo_de_movimiento, double offset_disparo_x, double offset_disparo_y) {
        val angulo = Math.toRadians(angulo_de_movimiento)

        agregarProyectil(new Bala(x + Math.cos(angulo) * separacion,
                                  y - Math.sin(angulo) * separacion,
                                  rotacion,
                                  angulo_de_movimiento))

        agregarProyectil(new Bala(x - Math.cos(angulo) * separacion,
                              y + Math.sin(angulo) * separacion,
                              rotacion,
                              angulo_de_movimiento))
	}
	
}