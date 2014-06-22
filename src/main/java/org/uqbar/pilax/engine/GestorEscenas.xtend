package org.uqbar.pilax.engine

import java.util.List

import static extension org.uqbar.pilax.utils.PythonUtils.*
import static extension org.uqbar.pilax.utils.PilasExtensions.*

class GestorEscenas {
	List<EscenaBase> escenas = newArrayList

	def void cambiarEscena(EscenaBase escena) {
		limpiar
		escenas.add(escena)
		escena.iniciar
		escena.iniciada = true
	}

	def limpiar() {
		escenas.forEach[it.limpiar]
        escenas = newArrayList
	}

	def escenaActual() {
		if(!escenas.empty) escenas.last else null
	}
	
	def actualizar() {
        val escena = escenaActual
        if (escena != null) {
            if (escena.iniciada) {
                escena.actualizarEventos
			}
			escenas.forEach[actualizarFisica]
        }
	}

    /** Pausa la escena actualmente activa e inicializa la escena que
       le pasamos como parametro.

        :param escena: Escena que deseamos que sea la activa.
     */	
	def almacenar_escena(EscenaBase escena) {
        if (escenaActual != null) {
            escenaActual.pausarFisica
            escenaActual.guardarPosicionCamara
            escenaActual.pausar
        }

        escenas.add(escena)
        escena.iniciar
        escena.camara.reiniciar
        escena.iniciada = true
    }
	
	def recuperar_escena() {
        /** Recupera la escena que fue Pausada mediante **almacenar_escena**.
        */
        if (!escenas.nullOrEmpty){
            escenas.last.limpiar()
            escenas.pop
            escenas.last => [
	            reanudarFisica
    	        recuperarPosicionCamara
        	    control.limpiar
            	reanudar
            ]
        }
        else
            throw new PilaxException("Debe haber al menos una escena en la pila para restaurar.")
	}
}