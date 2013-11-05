package org.uqbar.pilax.interpolacion.tweener

import java.util.Map
import org.apache.commons.beanutils.PropertyUtils
import org.eclipse.xtext.xbase.lib.Functions.Function4
import org.eclipse.xtext.xbase.lib.Procedures.Procedure0

import static extension org.uqbar.pilax.engine.PilasExtensions.*
import static extension org.uqbar.pilax.engine.PythonUtils.*

class Tween {
	@Property double duration
	@Property double delay
	@Property Object target
	@Property Easing tween
	@Property boolean complete = false
	@Property Map<String, Tweenable> tweenables
	double delta
	@Property Procedure0 completeFunction
	@Property Procedure0 updateFunction
	@Property String propertyName
	Tweenable tweenable
	@Property boolean paused
	double value
	
	new(Object obj, double duration, Easing tweenType, Procedure0 completeFunction, Procedure0 updateFunction, double delay, 
		String propertyName, Number startValue, Number endValue) {
		this.duration = duration
        this.delay = delay
        this.target = obj
        this.tween = tweenType
        this.delta = 0
        this.completeFunction = completeFunction
        this.updateFunction = updateFunction
        this.complete = False
        this.paused = this.delay > 0
        this.propertyName = propertyName
        
        this.value = endValue.doubleValue
        
//        val startVal = PropertyUtils.getProperty(this.target, propertyName) as Number
		val startVal = startValue
        this.tweenable = new Tweenable(startVal, endValue.minus(startVal))
	}
	
	
	/** Update this tween with the time since the last frame
        if there is an update function, it is always called
        whether the tween is running or paused*/	
	def void update(double ptime) {
        if (this.complete)
            return;
        
        if (this.paused) {
            if (this.delay > 0) {
                this.delay = Math.max(0, this.delay - ptime)
                if (this.delay == 0) {
                    this.paused = false
                    this.delay = -1
                }
                if (this.updateFunction != null)
                    this.updateFunction.apply()
            }
            return;
        }
 
        updateDelta(ptime)
       	setNextValue
        checkCompleted
 
        if (this.updateFunction != null)
            this.updateFunction.apply
	}

	def protected setNextValue() {
        PropertyUtils.setProperty(target, propertyName, nextValue)
	}

	def protected nextValue() {
		tween.nextValue(delta, tweenable.startValue.doubleValue, tweenable.change.doubleValue, duration)
	}

	def protected checkCompleted() {
		if (this.delta == this.duration) {
            this.complete = true
            if (this.completeFunction != null) {
                this.completeFunction.apply
            }
        }
	}

	def updateDelta(double ptime) {
		delta = Math.min(delta + ptime, this.duration)
	}
    
    def pause() {
    	pause(-1)
    }
	
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
    def Remove() {
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
        if (this.propertyName.equals(name))
        	tweenable
    }
}