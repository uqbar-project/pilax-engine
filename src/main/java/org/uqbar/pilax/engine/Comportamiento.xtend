package org.uqbar.pilax.engine

/**
 * Se agrega a un actor (Estudiante) y permite
 * colgarse del ciclo de ticks (o actualizaciones) para hacer cosas 
 * sobre él.
 * Por ejemplo, seguir al mouse, moverse con el teclado, etc.
 * La idea es que los comportamientos se pueden agregar y sacar
 * 
 */
abstract class Comportamiento<E extends Estudiante> {
	@Property E receptor

	/**
	 * Se invoca cuando se anexa el comportamiento a un actor.
     * @param receptor El actor que comenzará a ejecutar este comportamiento.
     */
	def iniciar(E receptor) {
        this.receptor = receptor
    }

	// este no esta en pilas. No entiendo como funciona :S
	def void eliminar() {}
	
	def boolean actualizar()
	
	def terminar() {}
	
}