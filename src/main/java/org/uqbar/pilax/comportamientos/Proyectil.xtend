package org.uqbar.pilax.comportamientos

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Comportamiento

import static extension org.uqbar.pilax.utils.PythonUtils.*

class Proyectil extends Comportamiento<Actor> {
	double velocidad = 0
	int aceleracion = 1
	double velocidad_maxima = 5
	double angulo_de_movimiento = 90
	int gravedad = 0
	double vy
		
	new(double velocidadMaxima, int aceleracion, double angulo, int gravedad) {
		this.velocidad_maxima = velocidadMaxima
		this.aceleracion = aceleracion
		this.angulo_de_movimiento = angulo
		this.gravedad = gravedad
	}
	
	override actualizar() {
		velocidad = velocidad + aceleracion

        if (velocidad > velocidad_maxima)
            velocidad = velocidad_maxima

        mover_respecto_angulo_movimiento
        
        false
	}
	
	def void mover_respecto_angulo_movimiento() {
        val rotacion_en_radianes = math.radians(-angulo_de_movimiento + 90)
        val dx = Math.cos(rotacion_en_radianes) * velocidad
        val dy = Math.sin(rotacion_en_radianes) * velocidad
        receptor.x = receptor.x + dx

        if (gravedad > 0) {
            receptor.y = receptor.y + dy + vy
            vy = vy - 0.1
        }
        else
            receptor.y = receptor.y + dy
	}
	
}