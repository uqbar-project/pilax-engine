package org.uqbar.pilax.geom

class Angulo {
	@Property double valor
	
	def void setValor(double rotacion) {
		val rot = if (rotacion < 0) 360 + rotacion else rotacion 
    	_valor = rot % 360
	}
	
	def void incrementar(double delta) {
		valor = valor + delta
	}
	
	def Angulo operator_add(double delta) {
		incrementar(delta)
		this
	}
	
	def getRadianes() {
		Math.toRadians(_valor)
	}
}