package org.uqbar.pilax.engine

class PilasExtensions {
	
	def static esActor(Object obj) {
		Pilas.instance.escenaActual.actores.contains(obj)
	}
	
	// TODO: borrar luego refactorizando. Es una chanchada de pilas
	def static eventos(Object obj) {
		Pilas.instance.escenaActual
	}
	
}