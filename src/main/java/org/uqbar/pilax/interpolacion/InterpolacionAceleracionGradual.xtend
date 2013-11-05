package org.uqbar.pilax.interpolacion

import java.util.List
import org.uqbar.pilax.interpolacion.tweener.Cubic

class InterpolacionAceleracionGradual extends Interpolacion {
	
	new(List<? extends Number> valores, int duracion, int delay) {
		super(valores, duracion, delay)
	}
	
	override apply(Object target, String propertyName) {
		apply(target, propertyName, [t,b,c,d | Cubic.easeIn(t,b,c,d)])
	}
	
}