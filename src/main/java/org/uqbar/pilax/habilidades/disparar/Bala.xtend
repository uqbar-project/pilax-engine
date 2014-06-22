package org.uqbar.pilax.habilidades.disparar

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.comportamientos.Proyectil

class Bala extends Actor {
	
	new() {
		this(0, 0)
	}
	
	new(double x, double y) {
		this(x, y, 0, 9, 90)
	}
	
	new(double x, double y, double rotacion, double angulo) {
		this(x, y, rotacion, 9, angulo)
	}
	
	new(double x, double y, double rotacion, double velocidadMaxima, double anguloMovimiento) {
		super("disparos/bola_amarilla.png", x, y)
		this.rotacion = rotacion
		radioDeColision = 5
		hacer(new Proyectil(velocidadMaxima, 1, anguloMovimiento, 0))
	}
	
}