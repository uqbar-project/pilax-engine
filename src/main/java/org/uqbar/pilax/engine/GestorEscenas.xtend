package org.uqbar.pilax.engine

import static extension org.uqbar.pilax.engine.PythonUtils.*
import java.util.List
import java.util.ArrayList

class GestorEscenas {
	List<EscenaBase> escenas = new ArrayList

	def cambiarEscena(EscenaBase escena) {
		limpiar
		escenas.add(escena)
		escena.iniciar
		escena.iniciada = true
	}

	def limpiar() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
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
