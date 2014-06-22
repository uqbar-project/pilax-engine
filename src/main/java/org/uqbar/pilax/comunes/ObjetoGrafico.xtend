package org.uqbar.pilax.comunes

import java.util.UUID

/**
 * Representa un objeto que se representa graficamente.
 * Esto nos permite tratar polimorficamente a los Actores y a las Figuras de la fisica.
 */
interface ObjetoGrafico {
	
	def UUID getId()
	
	def double getX()
	
	def void setX(double x)
	
	def double getY()
	
	def void setY(double y)
	
	def double getRotacion()
	
}