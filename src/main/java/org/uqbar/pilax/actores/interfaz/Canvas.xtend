package org.uqbar.pilax.actores.interfaz

import org.uqbar.pilax.motor.ImagenMotor

/**
 * Para hacer polimorficas a la Pizarra y la Superficie.
 * En Python no necesitaban esto.
 * Igual a nivel de diseño me hace ruido, se mezcla un actor con un actor del motor :S
 */
interface Canvas {
	
	def void pintarParteDeImagen(ImagenMotor imagen, double origen_x, double origen_y, double ancho, double alto, double x, double y)
	
}