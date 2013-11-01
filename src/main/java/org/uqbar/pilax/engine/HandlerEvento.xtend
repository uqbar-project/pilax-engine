package org.uqbar.pilax.engine

interface HandlerEvento<D extends DataEvento> {
	
	def void manejar(D data)
	
}