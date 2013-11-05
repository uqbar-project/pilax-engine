package org.uqbar.pilax.interpolacion.tweener

class Linear {

	def static Double easeNone(double t, double b, double c, double d) {
		c * t / d + b
	}

	def static easeIn(double t, double b, double c, double d) {
		easeNone(t, b, c, d)
	}

	def static easeOut(double t, double b, double c, double d) {
		easeNone(t, b, c, d)
	}

	def static easeInOut(double t, double b, double c, double d) {
		easeNone(t, b, c, d)
	}

}
