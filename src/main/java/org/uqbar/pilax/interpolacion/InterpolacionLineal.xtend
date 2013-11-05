package org.uqbar.pilax.interpolacion

import org.uqbar.pilax.interpolacion.Interpolacion
import java.util.List
import org.uqbar.pilax.interpolacion.tweener.Linear

class InterpolacionLineal extends Interpolacion {
	
	new(List<? extends Number> values, int duration, int delay) {
		super(values, duration, delay)
	}
	
	override apply(Object target, String propertyName) {
		apply(target, propertyName, [t,b,c,d | Linear.easeNone(t,b,c,d)])
	}
	
}