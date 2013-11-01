package org.uqbar.pilax.engine

import java.util.List

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
	
}
