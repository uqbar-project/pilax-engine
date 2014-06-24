package org.uqbar.pilax.engine

import java.util.List

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*
import org.uqbar.pilax.actores.PosicionCentro

//REVIEW: no se si está bueno que se maneje todo por la clase de las habilidades :S
class Estudiante {
	@Property List<Habilidad> habilidades = newArrayList
	@Property List<Comportamiento> comportamientos = newArrayList
	@Property Comportamiento comportamientoActual
	boolean repetirComportamientosPorSiempre
	
        /**Comienza a realizar una habilidad indicada por parametros.
        :param classname: Referencia a la clase que representa la habilidad.
        */
	def <H extends Habilidad> H aprender(Class<H> classname) {
        if (tieneHabilidad(classname)) {
            eliminarHabilidad(classname)
            agregarHabilidad(classname)
        }
        else
            agregarHabilidad(classname)
	}	
	
	/** Agrega una habilidad a la lista de cosas que puede hacer un actor.
        :param classname: Referencia a la clase que representa la habilidad.
        */
	def <H extends Habilidad> H agregarHabilidad(Class<H> classname) {
        val H habilidad = classname.newInstanceWith(this)
        habilidades.add(habilidad)
        habilidad
	}
	
	/** 
	 * Elimina una habilidad asociada a un Actor.
     * @param classname: Referencia a la clase que representa la habilidad.
     */	
    def eliminarHabilidad(Class aClass) {
        val habilidad = obtenerHabilidad(aClass)
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

	/**
	 * Obtiene la habilidad asociada a un Actor.
     * @param classname: Referencia a la clase que representa la habilidad.
     * @return: Devuelve None si no se encontró.
     */
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
     */	
    def hacerLuego(Comportamiento comportamiento, boolean repetir_por_siempre) {
        comportamientos += comportamiento
        repetirComportamientosPorSiempre = repetir_por_siempre
    }

	/** Define el comportamiento para el actor de manera inmediata.
        :param comportamiento: Referencia al comportamiento a realizar.
        */
    def hacer(Comportamiento comportamiento) {
        comportamientos += comportamiento
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
        if (comportamientoActual != null) {
            if (comportamientoActual.actualizar()) {
                if (repetirComportamientosPorSiempre)
                    comportamientos.add(comportamientoActual)
                adoptarElSiguienteComportamiento
            }
        }
        else
            adoptarElSiguienteComportamiento
	}

    def adoptarElSiguienteComportamiento() {
        if (!comportamientos.nullOrEmpty) {
            comportamientoActual = comportamientos.popAt(0)
            comportamientoActual.iniciar(this)
        }
        else
            comportamientoActual = null
    }
    
    def static centrada() {
    	PosicionCentro.CENTRO -> PosicionCentro.CENTRO
    }
	
}