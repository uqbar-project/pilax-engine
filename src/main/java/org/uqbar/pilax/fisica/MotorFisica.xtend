package org.uqbar.pilax.fisica

/**
 * Abstrae a pilas de la implementacion del motor física.
 * Existen dos implementaciones: 
 *    el dummy FisicaDeshabilitada
 *    y la que utiliza la libreria box2d
 */
 // esta interfaz está incompleta (herencia de pilas)
 // hay codigo de pilas que castea y le pega a la impl de box2d. 
interface MotorFisica {
	
	def void actualizar()
	
	def void reiniciar()
	
	def void pausarMundo()
	
	def void reanudarMundo()
	
	def void eliminarFigura(Figura f)
	
}