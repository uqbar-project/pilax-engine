package org.uqbar.pilax.interpolacion.tweener

class Linear {

	def static Double easeNone(double t, double b, double c, double d) {
		return c * t / d + b
	}

	def static easeIn(double t, double b, double c, double d) {
		return c * t / d + b
	}

	def static easeOut(double t, double b, double c, double d) {
		return c * t / d + b
	}

	def static easeInOut(double t, double b, double c, double d) {
		return c * t / d + b
	}

}
