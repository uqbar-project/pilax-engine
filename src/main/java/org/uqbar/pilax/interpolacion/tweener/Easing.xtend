package org.uqbar.pilax.interpolacion.tweener

/**
 * Un objeto que tiene la responsabilidad de calcular
 * el siguiente valor que va a tomar una interpolacion.
 * 
 * Son las comunmente llamandas easing functions.
 * Acá las modelamos como objetos con una única responsabilidad
 * Lo cual nos permite trabajarlas como bloques en extend, pero
 * seguimos teniéndolos modelados en lugar de usar Function4<Double, Double, Double, Double,Double>
 * 
 * @see http://easings.net/es
 * @see http://jqueryui.com/resources/demos/effect/easing.html
 * 
 * @author jfernandes
 */
interface Easing {
	
	/**
	 * t: delta
	 * b: start value
	 * c: change
	 * d: duration
	 */
	def double nextValue(double t, double b, double c, double d)
	
}