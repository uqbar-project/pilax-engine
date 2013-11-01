package org.uqbar.pilax.engine

class PilasExtensions {
	
	def static boolean esActor(Object obj) {
		Pilas.instance.escenaActual.actores.contains(obj)
	}
	
	// TODO: borrar luego refactorizando. Es una chanchada de pilas
	def static eventos(Object obj) {
		Pilas.instance.escenaActual
	}
	
	def static relativaALaCamara(Pair<Float, Float> coordenada) {
		coordenada.key + camaraX -> coordenada.value + Pilas.instance.mundo.motor.camaraY
	}
	
	def static camaraX() {
		Pilas.instance.mundo.motor.camaraX 
	}
	
	def static camaraY() {
		Pilas.instance.mundo.motor.camaraY
	}
	
}