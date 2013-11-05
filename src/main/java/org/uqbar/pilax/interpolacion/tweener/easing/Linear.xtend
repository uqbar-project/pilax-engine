package org.uqbar.pilax.interpolacion.tweener.easing

import org.uqbar.pilax.interpolacion.tweener.Easing

class LinearEasing implements Easing {
	override nextValue(double t, double b, double c, double d) {
		c * t / d + b
	}
}