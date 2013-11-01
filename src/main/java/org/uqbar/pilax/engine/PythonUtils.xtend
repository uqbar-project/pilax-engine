package org.uqbar.pilax.engine

import com.google.common.reflect.Reflection
import java.util.List

class PythonUtils {
	static boolean printNotImplemented = true
	
	def static <T> T self(T aThis) {
		aThis
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
	
	def static <E> E pop(List<E> list, int index) {
		list.remove(index)
	}
	
	def static void pass(Object obj) {
	}
	
	def static boolean False(Object obj) {
		false
	}
	
	def static boolean True(Object obj) {
		true
	}
	
	def static setattr(Object target, String attributeName, Object value) {
		Reflection.methods.findFirst[m| m.name.equals("set" + attributeName.toFirstUpper)].invoke(target, value)
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
	
}