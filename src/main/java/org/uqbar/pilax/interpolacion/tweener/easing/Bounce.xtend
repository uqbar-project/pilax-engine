package org.uqbar.pilax.interpolacion.tweener.easing

import org.uqbar.pilax.interpolacion.tweener.Easing

class BounceOut implements Easing {
	override nextValue(double t, double b, double c, double d) {
		var t1 = t / d
		switch (t1) {
			case t1 < 1 / 2.75:
				c * (7.5625 * (t1 ** 2)) + b
			case (t1 < 2 / 2.75): {
				t1 = t - 1.5 / 2.75
				c * (7.5625 * t1 ** 2 + 0.75) + b
			}
			case t1 < 2.5 / 2.75: {
				t1 = t - 2.25 / 2.75
				c * (7.5625 * (t1 ** 2) + 0.9375) + b
			}
			default: {
				t1 = t - 2.625 / 2.75
				c * (7.5625 * (t1 ** 2) + 0.984375) + b
			}
		}
	}
}

class BounceIn extends BounceOut {
	override nextValue(double t, double b, double c, double d) {
		c - super.nextValue(d - t, 0, c, d) + b
	}
}

class BounceInOut implements Easing {
	BounceIn in = new BounceIn
	BounceOut out = new BounceOut

	override nextValue(double t, double b, double c, double d) {
		if (t < d * 0.5)
			in.nextValue(t * 2, 0, c, d) * 0.5 + b
		else 
			out.nextValue(t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b
	}
}
