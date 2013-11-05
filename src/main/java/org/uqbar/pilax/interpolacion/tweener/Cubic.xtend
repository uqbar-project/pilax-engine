package org.uqbar.pilax.interpolacion.tweener

class Cubic {

	def static easeIn(double t, double b, double c, double d) {
    	val t1 = t / d
    	return c * (t1 ** 3) + b
	}

    def static easeOut(double t, double b, double c, double d) {
        val t1 = t / d - 1
        return c * (t1**3 + 1) + b
    }

	def static easeInOut (double t, double b, double c, double d) {
        var t1 = t / (d * 0.5)
        if (t1 < 1)
            return c * 0.5 * t1**3 + b
            
        t1 = t - 2
        return c * 0.5 * (t1**3 + 2) + b
	}

}