package org.uqbar.pilax.interpolacion

import java.util.List
import org.apache.commons.beanutils.PropertyUtils
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.interpolacion.tweener.Easing

class Interpolacion {
	@Property List<? extends Number> values
	@Property double duration
	@Property double delay
	@Property Easing easing

	new(List<? extends Number> values, double duration, double delay, Easing easing) {
		this.values = values
		this.duration = duration
		this.delay = delay
		this.easing = easing
	}
	
	/** 
      * Aplica la interpolación a un actor usando un método.
	  *
	  * Esta funcionalidad se utiliza para que toda interpolación
	  * se pueda acoplar a un actor.
	  *
	  * La idea es contar con la interpolación, un actor y luego
	  * ponerla en funcionamiento::
	  *
	  *      mi_interpolacion.apply(mono, set_rotation)
	  *
	  * de esta forma los dos objetos están y seguirán estando
	  * desacoplados.
	  */
	def void apply(Object target, String propertyName) {
		// Tiempo que se debe invertir para hacer cada interpolacion individual.
		val stepDuration = duration / values.size * 1000.0

		var previousValue = PropertyUtils.getProperty(target, propertyName) as Number

		var index = 0
		for (value : values) {
			val delayForStep = delay * 1000.0 + (index * stepDuration)
			Pilas.instance.escenaActual.tweener.addTweenNoArgs(
				target,
				propertyName,
				previousValue,
				value,
				delayForStep,
				stepDuration,
				easing
			)

			// El siguiente valor inicial sera el que ha alcanzado.
			previousValue = value
			index = index + 1
		}
	}

}