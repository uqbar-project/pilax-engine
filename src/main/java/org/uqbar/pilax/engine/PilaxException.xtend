package org.uqbar.pilax.engine

import java.lang.RuntimeException

/**
 * Clase base para las exceptions de Pilax
 * 
 * @author jfernandes
 */
class PilaxException extends RuntimeException {
	
	new(String message) {
		super(message)
	}
	
	new(String message, Exception cause) {
		super(message, cause)
	}
	
}