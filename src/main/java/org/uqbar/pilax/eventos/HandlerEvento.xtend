package org.uqbar.pilax.eventos

interface HandlerEvento<D extends DataEvento> {
	
	def void manejar(D data)
	
}