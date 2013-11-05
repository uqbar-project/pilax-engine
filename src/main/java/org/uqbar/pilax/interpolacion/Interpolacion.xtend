package org.uqbar.pilax.interpolacion

import java.util.List
import org.uqbar.pilax.engine.Pilas

import static extension org.uqbar.pilax.engine.PythonUtils.*
import org.eclipse.xtext.xbase.lib.Functions.Function4
import org.apache.commons.beanutils.PropertyUtils

abstract class Interpolacion {
	@Property List<? extends Number> values
	@Property double duration
	@Property double delay
	
	new(List<? extends Number> values, double duration, double delay) {
		this.values = values
		this.duration = duration
		this.delay = delay
	}

    /** Aplica la interpolación a un actor usando un método.

    Esta funcionalidad se utiliza para que toda interpolación
    se pueda acoplar a un actor.

    La idea es contar con la interpolación, un actor y luego
    ponerla en funcionamiento::

        mi_interpolacion.apply(mono, set_rotation)

    de esta forma los dos objetos están y seguirán estando
    desacoplados.*/	
	def apply(Object target, String propertyName, Function4<Double,Double,Double,Double,Double> type) {
        // Tiempo que se debe invertir para hacer cada interpolacion individual.
        val step = duration / values.size * 1000.0

        var currentValue = PropertyUtils.getProperty(target, propertyName) as Number

        var index = 0
        for (value : values) {
            Pilas.instance.escenaActual.tweener.addTweenNoArgs(target, propertyName, 
                    currentValue,
                   	value,
                   	delay * 1000.0 + (index * step),
                   	step,
                   	type
            )
            // El siguiente valor inicial sera el que ha alcanzado.
            currentValue = value
        }
    }
    
    def void apply(Object target, String propertyName)
}