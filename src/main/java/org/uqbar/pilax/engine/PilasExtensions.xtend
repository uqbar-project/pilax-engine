package org.uqbar.pilax.engine

import com.trolltech.qt.gui.QColor
import java.awt.Color
import java.io.File
import java.util.Collection
import java.util.List
import org.eclipse.xtext.xbase.lib.Functions.Function0
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
	
	def static String[] asStringArray(String aString) {
		val array = newArrayList()
		var i = 0
		while (i < aString.length) {
			array.add(aString.charAt(i))
			i = i + 1
		}
		val String[] t = newArrayOfSize(0) 
		array.toArray(t)
	}
	
	def static QColor asQColor(Color color) {
		new QColor(color.red, color.green, color.blue)	
	}
	
	def static <E> E first(List<E> aList) {
		aList.get(0)
	}
	
	def static void nTimes(Function0 procedure, int times) {
		for (n : 0..times) {
			procedure.apply
		}
	}
	
	def static <E> void removeIfContains(Collection<E> collection, E element) {
		if (collection.contains(element))
        	collection.remove(element)
	}
	
	// ************************************
	// ** Pairs as coordinates
	// ************************************
	
	def static <K,V> K x(Pair<K,V> pair) {
		pair.key
	}
	
	def static <K,V> V y(Pair<K,V> pair) {
		pair.value
	}
	
}