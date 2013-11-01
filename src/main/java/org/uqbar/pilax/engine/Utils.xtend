package org.uqbar.pilax.engine

import org.eclipse.xtext.xbase.lib.Pair

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
	
}