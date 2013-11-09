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

class Utils {
	
	def static Pair<Float,Float> aRelativa(Pair<Float, Float> p) {
		aRelativa(p.x, p.y)
	}
	
	def static Pair<Float,Float> aRelativa(float x, float y) {
		val centroFisico = motor.centroFisico
    	x - centroFisico.x -> centroFisico.y - y
	}
	
	def static aAbsoluta(int x, int y) {
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
	
	def static distanciaEntreDosPuntos(Pair<Integer,Integer> pair, Pair<Integer,Integer> pair2) {
		val x1 = pair.x
		val y1 = pair.y
		val x2 = pair2.x
		val y2 = pair2.y
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
		interpolar(obj, property, values, new CubicEaseIn)
	}

	def static interpolar(Object obj, String property, List<? extends Number> values, Easing easing) {
		new Interpolacion(values, 1, 0, easing).apply(obj, property)
	}
	
}