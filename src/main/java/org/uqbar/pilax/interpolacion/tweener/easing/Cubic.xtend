package org.uqbar.pilax.interpolacion.tweener.easing

import org.uqbar.pilax.interpolacion.tweener.Easing

class CubicEaseIn implements Easing {
	override nextValue(double t, double b, double c, double d) {
		val t1 = t / d
    	return c * (t1 ** 3) + b
	}
}

class CubicEaseOut implements Easing {
    override nextValue(double t, double b, double c, double d) {
        val t1 = t / d - 1
        return c * (t1**3 + 1) + b
    }
}

class CubicEaseInOut implements Easing {
	override nextValue(double t, double b, double c, double d) {
        var t1 = t / (d * 0.5)
        if (t1 < 1)
            return c * 0.5 * t1**3 + b
            
        t1 = t - 2
        return c * 0.5 * (t1**3 + 2) + b
	}
}