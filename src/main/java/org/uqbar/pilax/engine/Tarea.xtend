package org.uqbar.pilax.engine

abstract class AbstractTarea {
	@Property Tareas planificador
    @Property float timeOut
    @Property float dt
	@Property boolean unaVez
	
	new(Tareas planificador, float timeOut, float dt, boolean unaVez) {
		this.planificador = planificador
        this.timeOut = timeOut
        this.dt = dt
        this.unaVez = unaVez
	}
	
	def void ejecutar()

}

class Tarea extends AbstractTarea {
    @Property () => void funcion

	new(Tareas planificador, float timeOut, float dt, () => void funcion, boolean unaVez) {
		super(planificador, timeOut, dt, unaVez)
        this.funcion = funcion
	}
	
	override ejecutar() {
        funcion.apply
    }
	/** Quita la tarea del planificador para que no se vuelva a ejecutar. */
    def void eliminar() {
        planificador.eliminarTarea(this)
    }

	/** Termina la tarea (alias de eliminar). */
    def void terminar() {
        eliminar
	}
		
}

/**
 * Ejecuta la tarea en forma de una funcion que se evalua
 * a un booleano.
 * Se detiene si no devuelve True.
 */
 //TODO: no heredar de Tarea tradicional !
class TareaCondicional extends AbstractTarea {
	() => boolean condicion

	new(Tareas planificador, float timeOut, float dt, () => Boolean condicion) {
		super(planificador, timeOut, dt, false)
		this.condicion = condicion
	}
		
	override ejecutar() {
        val seguir = condicion.apply
        if (!seguir)
            unaVez = true
	}
	
}