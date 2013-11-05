package org.uqbar.pilax.interpolacion.tweener

import static extension org.uqbar.pilax.utils.XtendUtils.*
import java.util.List
import org.eclipse.xtext.xbase.lib.Functions.Function4

// Reemplazar por otro ?
// http://code.google.com/p/java-universal-tween-engine/

class Tweener {
	List<Tween> currentTweens
	Function4<Double,Double,Double,Double,Double> defaultTweenType
	double defaultDuration

	new() {
		this(0.5d, createEaseNoneProcedure())
	}
	
	def static createEaseNoneProcedure() {
		[Double t, Double b, Double c, Double d | Linear.easeNone(t,b,c,d) ]
	}

	/**	
	 * Tweener
	 * This class manages all active tweens, and provides a factory for
	 * creating and spawning tween motions.
	 */        
	new(double duration, Function4<Double,Double,Double,Double,Double> tween) {
        currentTweens = newArrayList
        defaultTweenType =  tween //tween or Easing.Linear.easeNone
        defaultDuration = duration //duration or 1.0
	}
	
	def hasTweens() {
        !currentTweens.empty
    }
    
    def addTweenNoArgs(Object obj, String propertyName, Number previousGivenValuevalue, Number value, double t_delay, double t_time, Function4<Double,Double,Double,Double,Double> t_type) {
        /** Similar a addTween, solo que se especifica la funcion y el valor de forma explicita. */
// 		val t_completeFunc = kwargs.pop("onCompleteFunction") as Procedure0
// 		val t_updateFunc = kwargs.pop("onUpdateFunction") as Procedure0

        val tw =  new Tween(obj, t_time, t_type, [|], [|], t_delay, propertyName, value, previousGivenValuevalue)
        currentTweens.add(tw)
        tw
    }
    
    def update(double timeSinceLastFrame) {
    	val removable = newArrayList
    	for (tween : currentTweens) {
            tween.update(timeSinceLastFrame)

            if (tween.complete)
            	removable.add(tween)
    	}
    
    	removable.forEach[currentTweens.remove(it)]
    }
    
    def eliminarTodas() {
        val a_eliminar = newArrayList
        for (t : currentTweens)
            a_eliminar.add(t)

		a_eliminar.forEach[currentTweens.remove(it)]
   }
}