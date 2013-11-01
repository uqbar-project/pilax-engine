package org.uqbar.pilax.engine

abstract class Comportamiento {
	@Property Estudiante receptor

	/**"""Se invoca cuando se anexa el comportamiento a un actor.

        :param receptor: El actor que comenzará a ejecutar este comportamiento.
        """ */
	def iniciar(Estudiante receptor) {
        this.receptor = receptor
    }

	// este no esta en pilas. No entiendo como funciona :S
	def void eliminar()
	
	def boolean actualizar()
	
	def terminar() {}
	
}