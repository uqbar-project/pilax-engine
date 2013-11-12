package org.uqbar.pilax.utils

import org.uqbar.pilax.engine.PilaxException
import java.util.Arrays
import java.util.Collection
import java.util.List
import java.util.Map
import java.util.Random
import org.apache.commons.beanutils.PropertyUtils
import org.eclipse.xtext.xbase.lib.IntegerRange
import com.google.common.collect.Iterables
import com.google.common.collect.Lists

class PythonUtils {
	static boolean printNotImplemented = true
	
	def static <T> T self(T aThis) {
		aThis
	}
	
	def static range(int from, int until) {
		range(from, until, 1)
	}
	
	def static range(int from, int until, int step) {
		new IntegerRange(from, until, step)
	}
	
	def static range(int numero) {
		0..numero
	}
	
	def static int id(Object obj) {
		System::identityHashCode(obj)
	}
	
	def static <T> T None(Object obj) {
		null
	}
	
	def static <E> E pop(List<E> list) {
		list.remove(list.size - 1)
	}
	
	def static <E> E popAt(List<E> list, int index) {
		list.remove(index)
	}
	
	def static <K,V> V pop(Map<K, V> map, K e) {
		map.remove(e)
	}
	
	def static <K,V> V popOr(Map<K, V> map, K e, V defaultValue) {
		if (map.containsKey(e))
			map.remove(e)
		else
			defaultValue
	}
	
	def static void pass(Object obj) {
	}
	
	def static boolean False(Object obj) {
		false
	}
	
	def static boolean True(Object obj) {
		true
	}
	
	def static void notImplementedYet(Object o) {
		if (printNotImplemented) {
			new UnsupportedOperationException("TODO: auto-generated method stub").printStackTrace
		}
	}
	
	def static <T> T newInstanceWith(Class<T> aClass, Object... params) {
		// dummy impl !!!
		val c = aClass.constructors.findFirst[c| c.parameterTypes.length == params.length]
		c.newInstance(params) as T
	}
	
	def static String urandom(int size) {
		val result = newByteArrayOfSize(25)
		new Random().nextBytes(result)
		Arrays.toString(result)
	}
	
	def static in(Object e, Collection col) {
		col.contains(e)
	}
	
	def static in(Object e, Map map) {
		map.containsKey(e)
	}
	
	def static <E> append(List<E> list, E e) {
		list.add(e)
	}
	
	def static <E> int len(Iterable<E> iterable) {
		iterable.size
	}
	
	def static <K,V> int len(Map<K,V> map) {
		map.size
	}
	
	def static setattr(Object target, String attributeName, Object value) {
		target.class.methods.findFirst[m| m.name.equals("set" + attributeName.toFirstUpper)].invoke(target, value)
	}
	
	def static hasattr(Object target, String attributeName) {
		getter(target, attributeName) != null
	}

	def static getter(Object target, String attributeName) {
		val getter = target.class.methods.findFirst[m| m.name.equals("get" + attributeName.toFirstUpper)]
		if (getter == null)
			throw new PilaxException("No getter for attribute '" +  attributeName + "' in  object '" + target + "'")
		getter
	}
	
	def static getattr(Object target, String attributeName) {
		getter(target, attributeName).invoke(target)
	}
	
	def static __dict__(Object target) {
		PropertyUtils.describe(target)
	}
	
	def static __dict__(Object target, String key) {
		target.__dict__.get(key)
	}
	
	def static int randint(int Min, int Max) {
		Min + (Math.random() * ((Max - Min) + 1)).intValue
	}
	
	def static <E> E choice(Iterable<E> list) {
		choice(Lists.newArrayList(list))
	}
	
	def static <E> E choice(List<E> list) {
		val index = randint(0, list.size - 1)
		list.get(index)
	}
	
}