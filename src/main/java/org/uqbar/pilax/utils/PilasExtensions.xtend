package org.uqbar.pilax.utils

import com.trolltech.qt.gui.QColor
import java.awt.Color
import java.io.File
import java.util.Collection
import java.util.List
import java.util.UUID
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import org.eclipse.xtext.xbase.lib.Functions.Function0
import org.eclipse.xtext.xbase.lib.IntegerExtensions
import org.eclipse.xtext.xbase.lib.Pair
import org.eclipse.xtext.xbase.lib.Procedures.Procedure0
import org.uqbar.pilax.engine.Pilas

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
		new QColor(color.red, color.green, color.blue, color.alpha)	
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
	// vistas como area
	def static <K,V> K ancho(Pair<K,V> pair) {
		pair.key
	} 
	
	def static <K,V> V alto(Pair<K,V> pair) {
		pair.value
	}
	
	def static UUID uuid() {
		UUID.randomUUID
	}
	
	def static int operator_or(int a, int b) {
		IntegerExtensions.bitwiseOr(a, b)
	}
	
	def static <E> List<E> subList(List<E> list, int from) {
		list.subList(from, list.size)
	}
	
	def static dispatch minus(Double a, Number b) { a - b.doubleValue }
	def static dispatch minus(Integer a, Number b) { a - b.intValue }

	def static void execAsync(Procedure0 proc) {
		Pilas.instance.service.execute([| proc.apply ])
//		new Thread().start 
	}
	
}