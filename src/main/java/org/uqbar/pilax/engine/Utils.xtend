package org.uqbar.pilax.engine

import org.eclipse.xtext.xbase.lib.Pair

class Utils {
	
	def static Pair<Float,Float> convertirDePosicionFisicaRelativa(float x, float y) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def static Area obtenerBordes() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
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