package org.uqbar.pilax.interpolacion.tweener.easing

import org.uqbar.pilax.interpolacion.tweener.Easing

class CircEaseIn implements Easing {
	override double nextValue(double t, double b, double c, double d) {
		val t1 = t / d
        return -c * (Math.sqrt(1 - t1**2) - 1) + b
	}
}

class CircEaseOut implements Easing {
	override double nextValue(double t, double b, double c, double d) {
		val t1 = t / d - 1
        return c * Math.sqrt(1 - t1**2) + b
	}
}

class CircEaseInOut implements Easing {
	override double nextValue(double t, double b, double c, double d) {
		var t1 = t / (d * 0.5)
        if (t1 < 1)
            return -c * 0.5 * (Math.sqrt(1 - t**2) - 1) + b
            
        t1 = t1 - 2
        return c*0.5 * (Math.sqrt(1 - t**2) + 1) + b
	}
}
