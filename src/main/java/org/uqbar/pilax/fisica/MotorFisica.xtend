package org.uqbar.pilax.fisica

interface MotorFisica {
	
	def void actualizar()
	
	def void reiniciar()
	
	def void pausarMundo()
	
	def void reanudarMundo()
	
	def void eliminarFigura(Figura f)
	
}