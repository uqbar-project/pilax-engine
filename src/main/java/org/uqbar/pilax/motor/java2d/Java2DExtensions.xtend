package org.uqbar.pilax.motor.java2d

import java.awt.Dimension

/**
 * Extension methods for java2d classes
 * 
 * @author jfernandes
 */
class Java2DExtensions {
	
	def static toDimension(Pair<Integer, Integer> widthHeightPair) {
		new Dimension(widthHeightPair.key, widthHeightPair.value)
	}
	
}