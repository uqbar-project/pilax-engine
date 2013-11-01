package org.uqbar.pilax.engine

import static extension org.uqbar.pilax.engine.PythonUtils.*
import java.util.List

class Estudiante {
	@Property List<Habilidad> habilidades = newArrayList
	@Property List<Comportamiento> comportamientos = newArrayList
	@Property Comportamiento comportamientoActual
	boolean repetirComportamientosPorSiempre
	
	/**""" Elimina una habilidad asociada a un Actor.

        :param classname: Referencia a la clase que representa la habilidad.
        """ */	
    def eliminar_habilidad(Class aClass) {
        val habilidad = self.obtenerHabilidad(aClass)
        if (habilidad != null)
            self._habilidades.remove(habilidad)
    }

	/** """Comprueba si el actor ha aprendido la habilidad indicada.
        :param classname: Referencia a la clase que representa la habilidad.
        """ */
    def tieneHabilidad(Class aClass) {
        self._habilidades.map[h| h.class].contains(aClass)
    }

	/**"""Comprueba si el actor tiene el comportamiento indicado.
        :param classname: Referencia a la clase que representa el comportamiento.
        """ */
    def tieneComportamiento(Class aClass) {
    	self.comportamientos.map[h| h.class].contains(aClass)
    }

	/** """Obtiene la habilidad asociada a un Actor.

        :param classname: Referencia a la clase que representa la habilidad.
        :return: Devuelve None si no se encontró.
        """ */
    def obtenerHabilidad(Class classname) {
        for (habilidad : self._habilidades) {
            if (habilidad.class == classname)
                return habilidad
        }
        return None
	}

	/** Define un nuevo comportamiento para realizar al final.
        Los actores pueden tener una cadena de comportamientos, este
        metodo agrega el comportamiento al final de la cadena.
        :param comportamiento: Referencia al comportamiento.
        :param repetir_por_siempre: Si el comportamiento se volverá a ejecutar luego de terminar.
        """ */	
    def hacerLuego(Comportamiento comportamiento, boolean repetir_por_siempre) {
        self.comportamientos.add(comportamiento)
        self.repetirComportamientosPorSiempre = repetir_por_siempre
    }

	/** Define el comportamiento para el actor de manera inmediata.
        :param comportamiento: Referencia al comportamiento a realizar.
        */
    def hacer(Comportamiento comportamiento) {
        self.comportamientos.add(comportamiento)
        self.adoptarElSiguienteComportamiento
	}

	/** "Elimina todas las habilidades asociadas al actor." */
    def eliminarHabilidades() {
    	self._habilidades.forEach[eliminar]
	}

	/** "Elimina todos los comportamientos que tiene que hacer el actor." */
    def eliminarComportamientos() {
    	self.comportamientos.forEach[eliminar]
    }

    def actualizarHabilidades() {
    	self._habilidades.forEach[actualizar]
    }

	/** "Actualiza la lista de comportamientos" */	
	def actualizarComportamientos() {
        var boolean termina = false

        if (self.comportamientoActual != null) {
            termina = self.comportamientoActual.actualizar()

            if (termina) {
                if (self.repetirComportamientosPorSiempre)
                    self.comportamientos.add(self.comportamientoActual)
                self.adoptarElSiguienteComportamiento()
            }
        }
        else
            self.adoptarElSiguienteComportamiento
	}

    def adoptarElSiguienteComportamiento() {
        if (comportamientos != null) {
            comportamientoActual = comportamientos.pop(0)
            comportamientoActual.iniciar(self)
        }
        else
            comportamientoActual = None
    }
	
	
}