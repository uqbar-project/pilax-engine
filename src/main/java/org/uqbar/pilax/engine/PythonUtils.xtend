package org.uqbar.pilax.engine

import java.util.List
import com.trolltech.qt.core.Qt

class PythonUtils {
	
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
	
	def static <T> T QtCore(T t) {
		t
	}
	
}