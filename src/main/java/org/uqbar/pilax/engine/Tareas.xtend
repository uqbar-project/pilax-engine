package org.uqbar.pilax.engine

import java.util.List
import org.eclipse.xtext.xbase.lib.Functions.Function0

import static extension org.uqbar.pilax.engine.PythonUtils.*

class Tareas {
	var List<Tarea> tareas_planificadas = newArrayList
    var contador_de_tiempo = 0f
    
    def obtener_cantidad_de_tareas_planificadas() {
        /**Retora la cantidad de tareas planificadas.*/
        return self.tareas_planificadas.size
    }
    
    /**Agrega una nueva tarea para ejecutarse luego.
       :param tarea: Referencia a la tarea que se debe agregar.
    */
	def agregar(Tarea tarea) {
        self.tareas_planificadas.add(tarea)
    }
    
    /**
     * """Elimina una tarea de la lista de tareas planificadas.
        :param tarea: Referencia a la tarea que se tiene que eliminar.
        """ */
    def eliminarTarea(Tarea tarea) {
        self.tareas_planificadas.remove(tarea)
    }

        /**Actualiza los contadores de tiempo y ejecuta las tareas pendientes.

        :param dt: Tiempo transcurrido desde la anterior llamada.
        */
    def actualizar(float dt) {
        self.contador_de_tiempo = self.contador_de_tiempo + dt
        val tareas_a_eliminar = newArrayList

        for (tarea : self.tareas_planificadas){
            if (self.contador_de_tiempo > tarea.time_out) {
                tarea.ejecutar()

                if (tarea.una_vez)
                    tareas_a_eliminar.add(tarea)
                else {
                    val w = self.contador_de_tiempo - tarea.time_out
                    val parte_entera = ((w)/ tarea.dt.floatValue).intValue
                    val resto = w - (parte_entera * tarea.dt)

                    for (x : range(parte_entera))
                        tarea.ejecutar()

                    tarea.time_out = tarea.time_out + tarea.dt + (parte_entera * tarea.dt) - resto
                }
            }
		}
        for (x : tareas_a_eliminar) {
            if (self.tareas_planificadas.contains(x))
                self.tareas_planificadas.remove(x)
        }
	}
	
    def unaVez(int time_out, Function0<Boolean> function) { // tenia params
        /**Genera una tarea que se ejecutará usan sola vez.

        :param time_out: Cantidad se segundos que deben transcurrir para ejecutar la tarea.
        :param function: Función a ejecutar para lanzar la tarea.
        :param params: Parámetros que tiene que recibir la función a ejecutar.
        */
        val tarea = new Tarea(self, self.contador_de_tiempo + time_out, time_out, function, true)
        self.agregar(tarea)
        tarea
    }

    def siempre(int time_out, Function0<Boolean> function) { // tenia params
        /**Genera una tarea para ejecutar todo el tiempo, sin expiración.

        :param time_out: Cantidad se segundos que deben transcurrir para ejecutar la tarea.
        :param function: Función a ejecutar para lanzar la tarea.
        :param params: Parámetros que tiene que recibir la función a ejecutar.
        */
        val tarea = new Tarea(self, self.contador_de_tiempo + time_out, time_out, function, false)
        self.agregar(tarea)
        tarea
	}

    def condicional(int time_out, Function0<Boolean> function) { // tenia params
        /**Genera una tarea que se puede ejecutar una vez o mas, pero que tiene una condición.

        La tarea se ejecutará hasta que la función a ejecutar revuelva False.

        :param time_out: Cantidad se segundos que deben transcurrir para ejecutar la tarea.
        :param function: Función a ejecutar para lanzar la tarea.
        :param params: Parámetros que tiene que recibir la función a ejecutar.
        */
        val tarea = new TareaCondicional(self, self.contador_de_tiempo + time_out, time_out, function, false)
        self.agregar(tarea)
        tarea
    }

       /**Elimina una tarea de la lista de tareas planificadas.

        :param tarea: Referencia a la tarea que se tiene que eliminar.
        */
    def eliminar_tarea(Tarea tarea) {
        self.tareas_planificadas.remove(tarea)
    }

        /**Elimina todas las tareas de la lista de planificadas.*/
    def eliminar_todas() {
        self.tareas_planificadas = newArrayList
    }
    
}