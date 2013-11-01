package org.uqbar.pilax.engine

import org.eclipse.xtext.xbase.lib.Functions.Function0

import static extension org.uqbar.pilax.engine.PythonUtils.*

class Tarea {
	@Property Tareas planificador
    @Property float time_out
    @Property float dt
    @Property Function0<Boolean> funcion
    @Property boolean una_vez

	new(Tareas planificador, float time_out, float dt, Function0<Boolean> funcion, boolean una_vez) {
		self.planificador = planificador
        self.time_out = time_out
        self.dt = dt
        self.funcion = funcion
        self.una_vez = una_vez
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
        self.eliminar()
	}
		
}


class TareaCondicional extends Tarea {

	new(Tareas planificador, float time_out, float dt, Function0<Boolean> funcion, boolean una_vez) {
		super(planificador, time_out, dt, funcion, una_vez)
	}
	
	/** """Ejecuta la tarea, y se detiene si no revuelve True.""" */	
	override ejecutar() {
        val retorno = super.ejecutar()

        if (!retorno)
            self.una_vez = true
        retorno
	}
	
}