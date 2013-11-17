package org.uqbar.pilax.engine

class Tarea {
	@Property Tareas planificador
    @Property float timeOut
    @Property float dt
    @Property () => Boolean funcion
    @Property boolean unaVez

	new(Tareas planificador, float timeOut, float dt, () => Boolean funcion, boolean unaVez) {
		this.planificador = planificador
        this.timeOut = timeOut
        this.dt = dt
        this.funcion = funcion
        this.unaVez = unaVez
	}
	
	def ejecutar() {
        funcion.apply
    }
	/** "Quita la tarea del planificador para que no se vuelva a ejecutar." */
    def eliminar() {
        planificador.eliminarTarea(this)
    }

	/**"Termina la tarea (alias de eliminar)." */
    def terminar() {
        eliminar
	}
		
}


class TareaCondicional extends Tarea {

	new(Tareas planificador, float timeOut, float dt, () => Boolean funcion, boolean unaVez) {
		super(planificador, timeOut, dt, funcion, unaVez)
	}
	
	/** """Ejecuta la tarea, y se detiene si no devuelve True.""" */	
	override ejecutar() {
        val retorno = super.ejecutar()

        if (!retorno)
            unaVez = true
        retorno
	}
	
}