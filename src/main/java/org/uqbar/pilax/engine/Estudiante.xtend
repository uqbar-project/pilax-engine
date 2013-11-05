package org.uqbar.pilax.engine

import java.util.List

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

class Estudiante {
	@Property List<Habilidad> habilidades = newArrayList
	@Property List<Comportamiento> comportamientos = newArrayList
	@Property Comportamiento comportamientoActual
	boolean repetirComportamientosPorSiempre
	
        /**Comienza a realizar una habilidad indicada por parametros.
        :param classname: Referencia a la clase que representa la habilidad.
        */
	def <H extends Habilidad> H aprender(Class<H> classname) {
        if (self.tieneHabilidad(classname)) {
            self.eliminar_habilidad(classname)
            self.agregar_habilidad(classname)
        }
        else
            self.agregar_habilidad(classname)
	}	
	
	/** Agrega una habilidad a la lista de cosas que puede hacer un actor.
        :param classname: Referencia a la clase que representa la habilidad.
        */
	def <H extends Habilidad> H agregar_habilidad(Class<H> classname) {
        val H habilidad = classname.newInstanceWith(this)
        habilidades.add(habilidad)
        habilidad
	}
	
	/**""" Elimina una habilidad asociada a un Actor.

        :param classname: Referencia a la clase que representa la habilidad.
        """ */	
    def eliminar_habilidad(Class aClass) {
        val habilidad = self.obtenerHabilidad(aClass)
        if (habilidad != null)
            _habilidades.remove(habilidad)
    }

	/** """Comprueba si el actor ha aprendido la habilidad indicada.
        :param classname: Referencia a la clase que representa la habilidad.
        """ */
    def tieneHabilidad(Class aClass) {
        habilidades.map[h| h.class].contains(aClass)
    }

	/**"""Comprueba si el actor tiene el comportamiento indicado.
        :param classname: Referencia a la clase que representa el comportamiento.
        """ */
    def tieneComportamiento(Class aClass) {
    	comportamientos.map[h| h.class].contains(aClass)
    }

	/** """Obtiene la habilidad asociada a un Actor.

        :param classname: Referencia a la clase que representa la habilidad.
        :return: Devuelve None si no se encontró.
        """ */
    def obtenerHabilidad(Class classname) {
        for (habilidad : habilidades) {
            if (habilidad.class == classname)
                return habilidad
        }
        return null
	}

	/** Define un nuevo comportamiento para realizar al final.
        Los actores pueden tener una cadena de comportamientos, este
        metodo agrega el comportamiento al final de la cadena.
        :param comportamiento: Referencia al comportamiento.
        :param repetir_por_siempre: Si el comportamiento se volverá a ejecutar luego de terminar.
        """ */	
    def hacerLuego(Comportamiento comportamiento, boolean repetir_por_siempre) {
        comportamientos.add(comportamiento)
        repetirComportamientosPorSiempre = repetir_por_siempre
    }

	/** Define el comportamiento para el actor de manera inmediata.
        :param comportamiento: Referencia al comportamiento a realizar.
        */
    def hacer(Comportamiento comportamiento) {
        comportamientos.add(comportamiento)
        adoptarElSiguienteComportamiento
	}

	/** "Elimina todas las habilidades asociadas al actor." */
    def eliminarHabilidades() {
    	habilidades.forEach[eliminar]
	}

	/** "Elimina todos los comportamientos que tiene que hacer el actor." */
    def eliminarComportamientos() {
    	comportamientos.forEach[eliminar]
    }

    def actualizarHabilidades() {
    	habilidades.forEach[actualizar]
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
        if (!comportamientos.nullOrEmpty) {
            comportamientoActual = comportamientos.pop(0)
            comportamientoActual.iniciar(this)
        }
        else
            comportamientoActual = null
    }
	
}