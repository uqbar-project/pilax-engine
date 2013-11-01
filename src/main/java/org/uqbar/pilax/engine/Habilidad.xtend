package org.uqbar.pilax.engine

abstract class Habilidad {
	@Property Actor receptor
	
	new(Actor receptor) {
		this.receptor = receptor
	}
	
	def void actualizar() {}
	
	def void eliminar() {}
	
}