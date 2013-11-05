package org.uqbar.pilax.engine

import static extension org.uqbar.pilax.engine.PilasExtensions.*

import org.eclipse.xtext.xbase.lib.Pair
import java.util.List
import org.uqbar.pilax.interpolacion.InterpolacionAceleracionGradual
import org.uqbar.pilax.interpolacion.InterpolacionLineal

class Utils {
	
	def static Pair<Float,Float> convertirDePosicionFisicaRelativa(float x, float y) {
		val centroFisico = Pilas.instance.mundo.motor.centroFisico
		val dx = centroFisico.key
		val dy = centroFisico.value 
    	x - dx -> dy - y
	}
	
	def static Area obtenerBordes() {
		val area = Pilas.instance.mundo.motor.area
		val ancho = area.key
		val alto = area.value
    	return new Area(-ancho/2, ancho/2, alto/2, -alto/2)
	}
	
	def static colisionan(Actor a, Actor b) {
		distanciaEntreDosActores(a, b) < a.radioDeColision + b.radioDeColision
	}
	
	def static distanciaEntreDosActores(Actor a, Actor b) {
		distanciaEntreDosPuntos((a.x -> a.y), (b.x -> b.y))
	}
	
	def static distanciaEntreDosPuntos(Pair<Integer,Integer> pair, Pair<Integer,Integer> pair2) {
		val x1 = pair.key
		val y1 = pair.value
		val x2 = pair2.key
		val y2 = pair2.value
		Math.sqrt(distancia(x1, x2) ** 2 + distancia(y1, y2) ** 2)
	}
	
	def static distancia(Integer a, Integer b) {
		Math.abs(b - a)
	}

	/**
		Busca la ruta a un archivo de recursos.

    	Los archivos de recursos (como las imagenes) se buscan en varios
    	directorios (ver docstring de image.load), así que esta
    	función intentará dar con el archivo en cuestión.

    	:param ruta: Ruta al archivo (recurso) a inspeccionar.
    */
    // En PILAS buscar en los directorios del sistema operativo. Acá usamos el classpath	
	def static obtenerRutaAlRecurso(String pathRelativo) {
		pathRelativo.resolveFullPathFromClassPath    	
	}
	
	def static interpolar(Object obj, String property, List<? extends Number> values) {
//		[| 
			
//			new InterpolacionAceleracionGradual(values, 1, 0).apply(obj, property)
			new InterpolacionLineal(values, 1, 0).apply(obj, property)
//		].execAsync

	}
	
}