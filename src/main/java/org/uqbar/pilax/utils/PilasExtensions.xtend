package org.uqbar.pilax.utils

import java.io.File
import java.util.Collection
import java.util.List
import java.util.UUID
import org.eclipse.xtext.xbase.lib.Functions.Function0
import org.eclipse.xtext.xbase.lib.IntegerExtensions
import org.eclipse.xtext.xbase.lib.Pair
import org.eclipse.xtext.xbase.lib.Procedures.Procedure0
import org.uqbar.pilax.engine.EscenaBase
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.engine.PilaxException
import org.uqbar.pilax.geom.Angulo

class PilasExtensions {
	
	def static Pilas pilas(Object obj) {
		Pilas.instance
	}
	
	def static boolean esActor(Object obj) {
		Pilas.instance.escenaActual.actores.contains(obj)
	}
	
	// TODO: borrar luego refactorizando. Es una chanchada de pilas
	def static EscenaBase eventos(Object obj) {
		Pilas.instance.escenaActual
	}
	
	def static relativaALaCamara(Pair<Double, Double> coordenada) {
		coordenada + motor.centroDeLaCamara
	}
	
	def static getMotor() {
		Pilas.instance.mundo.motor
	}
	
	// *********************************
	// ** Closures
	// *********************************
	
	def static void nTimes(Function0 procedure, int times) {	for (n : 1..times) procedure.apply	}
	def static void nTimes(Procedure0 procedure, int times) {	for (n : 1..times) procedure.apply	}
	
	// *********************************
	// ** Miscs
	// *********************************
	
	def static resolveFullPathFromClassPath(String fileName) {
		val url = typeof(PilasExtensions).classLoader.getResource(fileName)
		if (url == null) throw new PilaxException("No se encontro el archivo para la imagen '" + fileName + "' en el classpath!")
		new File(url.toURI).absolutePath
	}
	
	def static void execAsync(Procedure0 proc) {
		Pilas.instance.service.execute([| proc.apply ])
	}
	
	// *********************************
	// ** Collections
	// *********************************
	
	def static <E> List<E> operator_multiply(List<E> list, int number) {
		val r = newArrayList;
		[| r.addAll(list)].nTimes(number)
		r
	}
	
	def static <E> List<E> subList(List<E> list, int from) {
		list.subList(from, list.size)
	}
	
	def static <E> asList(E e) {
		newArrayList(e)
	}
	
	def static <E> List<E> copy(List<E> aList) {
		copy(aList as Iterable) as List
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
	
	
	def static <E> E first(List<E> aList) {
		aList.get(0)
	}
	
	def static <E> void removeIfContains(Collection<E> collection, E element) {
		if (collection.contains(element))
        	collection.remove(element)
	}
	
	// ************************************
	// ** Pairs
	// ************************************
	
	def static <X,Y> Pair<X,Y> copy(Pair<X,Y> p) {
		p.x -> p.y
	} 
	
	def static <E> Pair<E,E> asPair(E e) {
		e -> e
	}
	
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
	
	def static <E extends Comparable> E min(Pair<E, E> p) {
		if (p.key <= p.value ) 
			p.key
		else
			p.value
	}
	
	def static <N extends Number> Pair<Float,Float> asFloat(Pair<N,N> p) {
		p.key.floatValue -> p.value.floatValue
	}
	
	def static <N extends Number> Pair<Integer,Integer> asInteger(Pair<N,N> p) {
		p.key.intValue -> p.value.intValue
	}
	
	def static Pair<Double,Double> operator_minus(Pair<Double,Double> p1, Pair<Double,Double> p2) {
		(p1.key - p2.key -> p1.value - p2.value)
	}
	
	def static Pair<Double,Double> operator_plus(Pair<Double,Double> p1, Pair<Double,Double> p2) {
		(p1.x + p2.x -> p1.y + p2.y)
	}
	
	def static Pair<Double,Double> operator_divide(Pair<Double,Double> pair, Integer divisor) {
		pair.x / divisor -> pair.y / divisor
	}
	
	def static Pair<Double,Double> operator_modulo(Pair<Double,Double> pair, Integer divisor) {
		pair.x % divisor -> pair.y % divisor
	}
	
	def static Pair<Double,Double> origen() {
		(0d -> 0d)
	}
	
	def static Pair<Integer,Integer> toInt(Pair<Float,Float> p) {
		p.key.intValue -> p.value.intValue
	}
	
	def static UUID uuid() {
		UUID.randomUUID
	}
	
	// ************************************
	// ** numbers
	// ************************************
	
	def static int operator_or(int a, int b) {
		IntegerExtensions.bitwiseOr(a, b)
	}
	
	def static dispatch minus(Double a, Number b) { a - b.doubleValue }
	def static dispatch minus(Integer a, Number b) { a - b.intValue }
	
	def static int abs(int n) {
		Math.abs(n)		
	}
	
	// ***************************
	// ** geom
	
	def static Pair<Double,Double> polarACartesiana(Angulo angulo, double largo) {
		val rx = Math.cos(angulo.radianes) * largo;
		val ry = Math.sin(angulo.radianes) * largo;
		(rx -> ry)
	}
}