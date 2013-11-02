package org.uqbar.pilax.engine

import java.io.File
import java.util.List
import org.eclipse.xtext.xbase.lib.Pair

class PilasExtensions {
	
	def static Pilas pilas(Object obj) {
		Pilas.instance
	}
	
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
	
	// *********************************
	// ** generales
	// *********************************
	
	def static resolveFullPathFromClassPath(String fileName) {
		val url = typeof(PilasExtensions).classLoader.getResource(fileName)
		new File(url.toURI).absolutePath
	}
	
	def static <E> Iterable<E> copy(Iterable<E> aList) {
		val temp = newArrayList
		temp.addAll(aList)
		temp
	} 
	
}