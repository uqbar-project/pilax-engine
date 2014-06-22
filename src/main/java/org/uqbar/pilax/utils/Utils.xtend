package org.uqbar.pilax.utils

import java.util.List
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.geom.Area
import org.uqbar.pilax.interpolacion.Interpolacion
import org.uqbar.pilax.interpolacion.tweener.Easing
import org.uqbar.pilax.interpolacion.tweener.easing.CubicEaseIn

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import org.uqbar.pilax.interpolacion.tweener.easing.LinearEasing

class Utils {
	
	def static Pair<Double,Double> aRelativa(Pair<Double, Double> p) {
		aRelativa(p.x, p.y)
	}
	
	def static Pair<Double,Double> aRelativa(double x, double y) {
		val centroFisico = motor.centroFisico
    	x - centroFisico.x -> centroFisico.y - y
	}
	
	def static aAbsoluta(double x, double y) {
		val centro = motor.centroFisico
    	return (x + centro.x -> centro.y - y)
	}

	def static getMotor() {
		Pilas.instance.mundo.motor
	}
	
	def static Area getBordes() {
		motor.bordes
	}
	
	def static colisionan(Actor a, Actor b) {
		distanciaEntreDosActores(a, b) < a.radioDeColision + b.radioDeColision
	}
	
	def static distanciaEntreDosActores(Actor a, Actor b) {
		distanciaEntreDosPuntos((a.x.intValue -> a.y.intValue), (b.x.intValue -> b.y.intValue))
	}
	
	def static distanciaEntreDosPuntos(Pair<Integer,Integer> p1, Pair<Integer,Integer> p2) {
		Math.sqrt(distancia(p1.x, p2.x) ** 2 + distancia(p1.y, p2.y) ** 2)
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
		interpolar(obj, property, values, new CubicEaseIn)
	}

	def static interpolar(Object obj, String property, List<? extends Number> values, Easing easing) {
		interpolar(obj, property, values, 1, easing)
	}
	
	def static interpolar(Object obj, String property, List<? extends Number> values, double duracion) {
		interpolar(obj, property, values, duracion, new LinearEasing)
	} 
	
	def static interpolar(Object obj, String property, List<? extends Number> values, double duracion, Easing easing) {
		new Interpolacion(values, duracion, 0, easing).apply(obj, property)
	}
	
	def static fabricar(Class clase, int cantidad) {
		fabricar(clase, cantidad, true)
	}
	
	def static fabricar(Class clase, int cantidad, boolean posiciones_al_azar) {
    	val objetos_creados = newArrayList

    	for (i : PythonUtils.range(cantidad)) {
    		var x = 0
    		var y = 0
        	if (posiciones_al_azar) {
            	val area = Pilas.instance.mundo.area
            	val mitad_ancho = area.ancho / 2
            	val mitad_alto = area.alto / 2
            	x = PythonUtils.randint(-mitad_ancho.intValue, mitad_ancho.intValue)
            	y = PythonUtils.randint(-mitad_alto.intValue, mitad_alto.intValue)
            }
	        
	        val nuevo = PythonUtils.newInstanceWith(clase, x, y)
	        objetos_creados.add(nuevo)
        }
        return objetos_creados
	}
}