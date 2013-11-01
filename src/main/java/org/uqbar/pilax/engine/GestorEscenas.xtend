package org.uqbar.pilax.engine

import static extension org.uqbar.pilax.engine.PythonUtils.*
import java.util.List
import java.util.ArrayList

class GestorEscenas {
	List<EscenaBase> escenas = newArrayList

	def cambiarEscena(EscenaBase escena) {
		limpiar
		escenas.add(escena)
		escena.iniciar
		escena.iniciada = true
	}

	def limpiar() {
		self.escenas.forEach[it.limpiar]
        self.escenas = newArrayList
	}

	def escenaActual() {
		if(!escenas.empty) escenas.last else null
	}
	
	def actualizar() {
        val escena = escenaActual
        if (escena != null) {
            if (escena.iniciada)
                escena.actualizarEventos

            for (e : escenas)
                e.actualizarFisica
        }
	}
	
}
