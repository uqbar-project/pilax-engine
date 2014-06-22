package org.uqbar.pilax.interpolacion.tweener

import java.util.List
import org.eclipse.xtext.xbase.lib.Functions.Function4
import org.uqbar.pilax.interpolacion.tweener.easing.LinearEasing

// Reemplazar por otro ?
// http://code.google.com/p/java-universal-tween-engine/

class Tweener {
	List<Tween> currentTweens
	Easing defaultTweenType
	double defaultDuration

	new() {
		this(0.5d, new LinearEasing)
	}

	/**	
	 * Tweener
	 * This class manages all active tweens, and provides a factory for
	 * creating and spawning tween motions.
	 */        
	new(double duration, Easing tween) {
        currentTweens = newArrayList
        defaultTweenType =  tween
        defaultDuration = duration //duration or 1.0
	}
	
	def hasTweens() {
        !currentTweens.empty
    }
    
    /** Similar a addTween, solo que se especifica la funcion y el valor de forma explicita. */
    def addTweenNoArgs(Object obj, String propertyName, Number startValue, Number endValue, double delay, double time, Easing easing) {
// 		val t_completeFunc = kwargs.pop("onCompleteFunction") as Procedure0
// 		val t_updateFunc = kwargs.pop("onUpdateFunction") as Procedure0

        val tw =  new Tween(obj, time, easing, [|], [|], delay, propertyName, startValue, endValue)
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
    	currentTweens.clear
   }
}