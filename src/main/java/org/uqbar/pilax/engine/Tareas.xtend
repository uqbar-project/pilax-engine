package org.uqbar.pilax.engine

import java.util.List
import org.eclipse.xtext.xbase.lib.Functions.Function0

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

/**
 * 
 */
class Tareas {
	var List<Tarea> tareasPlanificadas = newArrayList
    var contadorDeTiempo = 0f
    
    def obtener_cantidad_de_tareasPlanificadas() {
        /**Retora la cantidad de tareas planificadas.*/
        return tareasPlanificadas.size
    }
    
    /**Agrega una nueva tarea para ejecutarse luego.
       :param tarea: Referencia a la tarea que se debe agregar.
    */
	def agregar(Tarea tarea) {
        tareasPlanificadas.add(tarea)
        tarea
    }
    
    /**
     * """Elimina una tarea de la lista de tareas planificadas.
        :param tarea: Referencia a la tarea que se tiene que eliminar.
        """ */
    def eliminarTarea(Tarea tarea) {
        tareasPlanificadas.remove(tarea)
    }

        /**Actualiza los contadores de tiempo y ejecuta las tareas pendientes.

        :param dt: Tiempo transcurrido desde la anterior llamada.
        */
    def actualizar(float dt) {
        contadorDeTiempo = contadorDeTiempo + dt
        val tareasAEliminar = newArrayList

        for (tarea : tareasPlanificadas){
            if (contadorDeTiempo > tarea.timeOut) {
                tarea.ejecutar

                if (tarea.unaVez)
                    tareasAEliminar.add(tarea)
                else {
                    val w = contadorDeTiempo - tarea.timeOut
                    val parteEntera = ((w)/ tarea.dt.floatValue).intValue
                    val resto = w - (parteEntera * tarea.dt)
					
					[|tarea.ejecutar()].nTimes(parteEntera)
					
                    tarea.timeOut = tarea.timeOut + tarea.dt + (parteEntera * tarea.dt) - resto
                }
            }
		}
		
		tareasAEliminar.forEach[tareasPlanificadas.removeIfContains(it)]
	}

	/**Genera una tarea que se ejecutará usan sola vez.

        :param time_out: Cantidad se segundos que deben transcurrir para ejecutar la tarea.
        :param function: Función a ejecutar para lanzar la tarea.
        :param params: Parámetros que tiene que recibir la función a ejecutar.
    */	
    def unaVez(float time_out, Function0<Boolean> function) { // tenia params
        agregarTarea(time_out, function, true)
    }
    
    def protected agregarTarea(float timeOut, Function0<Boolean> function, boolean unaVez) {
        agregar(new Tarea(this, contadorDeTiempo + timeOut, timeOut, function, unaVez))
    }

	/**	Genera una tarea para ejecutar todo el tiempo, sin expiración.
        :param time_out: Cantidad se segundos que deben transcurrir para ejecutar la tarea.
        :param function: Función a ejecutar para lanzar la tarea.
        :param params: Parámetros que tiene que recibir la función a ejecutar.
    */
    def siempre(float time_out, Function0<Boolean> function) { // tenia params
        agregarTarea(time_out, function, false)
	}

	/**Genera una tarea que se puede ejecutar una vez o mas, pero que tiene una condición.

        La tarea se ejecutará hasta que la función a ejecutar revuelva False.

        :param time_out: Cantidad se segundos que deben transcurrir para ejecutar la tarea.
        :param function: Función a ejecutar para lanzar la tarea.
        :param params: Parámetros que tiene que recibir la función a ejecutar.
    */
    def condicional(float time_out, Function0<Boolean> function) { // tenia params
        agregar(new TareaCondicional(this, contadorDeTiempo + time_out, time_out, function, false))
    }

       /**Elimina una tarea de la lista de tareas planificadas.

        :param tarea: Referencia a la tarea que se tiene que eliminar.
        */
    def eliminar_tarea(Tarea tarea) {
        tareasPlanificadas.remove(tarea)
    }

        /**Elimina todas las tareas de la lista de planificadas.*/
    def eliminarTodas() {
        tareasPlanificadas = newArrayList
    }
    
}