package org.uqbar.pilax.engine

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

class Control {
	@Property boolean izquierda
	@Property boolean derecha
	@Property boolean arriba
	@Property boolean abajo
	@Property boolean boton
	
	new(EscenaBase escena) {
        escena.pulsaTecla.conectar("control", [data| cuando_pulsa_una_tecla(data) ])
        escena.sueltaTecla.conectar("control", [data| cuando_suelta_una_tecla(data) ])
    }

    def cuando_pulsa_una_tecla(DataEvento evento) {
        self.procesar_cambio_de_estado_en_la_tecla((evento as DataEventoTeclado).tecla, true)
	}
	
    def cuando_suelta_una_tecla(DataEvento evento) {
        self.procesar_cambio_de_estado_en_la_tecla((evento as DataEventoTeclado).tecla, false)
    }

    def procesar_cambio_de_estado_en_la_tecla(Tecla codigo, boolean estado) {
    	if (codigo == Tecla.IZQUIERDA) izquierda = true
    	if (codigo == Tecla.DERECHA) derecha = true
    	if (codigo == Tecla.ARRIBA) arriba = true
    	if (codigo == Tecla.ABAJO) abajo = true
    	if (codigo == Tecla.ESPACIO) boton = true
    }

    def limpiar() {
        izquierda = false
        derecha = false
        arriba = false
        abajo = false
        boton = false
	}

}