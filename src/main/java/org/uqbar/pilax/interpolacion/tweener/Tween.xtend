package org.uqbar.pilax.interpolacion.tweener

import org.apache.commons.beanutils.PropertyUtils
import org.eclipse.xtext.xbase.lib.Procedures.Procedure0

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class Tween {
	// updating model
	@Property Object target
	@Property String propertyName
	
	@Property double duration
	@Property double delay
	@Property Easing tween
	@Property boolean complete = false
	double delta = 0
	@Property Procedure0 completeFunction
	@Property Procedure0 updateFunction
	Tweenable tweenable
	@Property boolean paused
	
	new(Object obj, double duration, Easing tweenType, Procedure0 completeFunction, Procedure0 updateFunction, double delay, 
		String propertyName, Number startValue, Number endValue) {
		this.duration = duration
        this.delay = delay
        this.target = obj
        this.propertyName = propertyName
        this.tween = tweenType
        this.completeFunction = completeFunction
        this.updateFunction = updateFunction
        this.paused = this.delay > 0
        
        this.tweenable = new Tweenable(startValue, endValue.minus(startValue))
	}
	
	
	/** Update this tween with the time since the last frame
        if there is an update function, it is always called
        whether the tween is running or paused*/	
	def void update(double ptime) {
        if (complete)
            return;
        
        if (paused) {
            if (delay > 0) {
                delay = Math.max(0, delay - ptime)
                if (delay == 0) {
                    paused = false
                    delay = -1
                }
                if (updateFunction != null)
                    updateFunction.apply()
            }
            return;
        }
 
        updateDelta(ptime)
       	setNextValue
        checkCompleted
 
        if (updateFunction != null)
            updateFunction.apply
	}

	def protected setNextValue() {
        PropertyUtils.setProperty(target, propertyName, nextValue)
	}

	def protected nextValue() {
		tween.nextValue(delta, tweenable.startValue.doubleValue, tweenable.change.doubleValue, duration)
	}

	def protected checkCompleted() {
		if (delta == duration) {
            complete = true
            if (completeFunction != null) {
                completeFunction.apply
            }
        }
	}

	def updateDelta(double ptime) {
		delta = Math.min(delta + ptime, this.duration)
	}
    
    def pause() { pause(-1) }
    
	/**Pause this tween
            do tween.pause( 2 ) to pause for a specific time
            or tween.pause() which pauses indefinitely.*/
    def pause(int numSeconds) {
        paused = true
        delay = numSeconds
    }
 
    /** Resume from pause */
    def resume() {
        if (paused)
            paused = false
	}

 	/** Disables and removes this tween
       without calling the complete function */
    def remove() {
        complete = true
    }

	/** Return the tweenable values corresponding to the name of the original
        tweening function or property. 
 
        Allows the parameters of tweens to be changed at runtime. The parameters
        can even be tweened themselves!
 
        eg:
 
        # the rocket needs to escape!! - we're already moving, but must go faster!
        twn = tweener.getTweensAffectingObject( myRocket )[0]
        tweenable = twn.getTweenable( "thrusterPower" )
        tweener.addTween( tweenable, change=1000.0, tweenTime=0.4, tweenType=tweener.IN_QUAD )
 
     */    
    def getTweenable(String name) {
        if (propertyName.equals(name))
        	tweenable
    }
}