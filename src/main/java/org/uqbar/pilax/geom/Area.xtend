package org.uqbar.pilax.geom

class Area {
	@Property double izquierda
	@Property double derecha
	@Property double arriba
	@Property double abajo
	
	new(double izquierda, double derecha, double arriba, double abajo) {
		this.izquierda = izquierda
		this.derecha = derecha
		this.arriba = arriba
		this.abajo = abajo
	}
	
}