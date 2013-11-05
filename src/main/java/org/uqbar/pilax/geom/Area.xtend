package org.uqbar.pilax.geom

class Area {
	@Property int izquierda
	@Property int derecha
	@Property int arriba
	@Property int abajo
	
	new(int izquierda, int derecha, int arriba, int abajo) {
		this.izquierda = izquierda
		this.derecha = derecha
		this.arriba = arriba
		this.abajo = abajo
	}
	
}