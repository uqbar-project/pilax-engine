package org.uqbar.pilax.interpolacion.tweener

class Tweenable {
	@Property Number startValue
	@Property Number change
	
	/** Tweenable:
      * Holds values for anything that can be tweened
      * these are normally only created by Tweens 
      */
    new (Number start, Number change) {
        this.startValue = start
        this.change = change
    }
}