package org.uqbar.pilax.engine

import org.uqbar.pilax.eventos.DataEventoTeclado

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

    def cuando_pulsa_una_tecla(DataEventoTeclado evento) {
        procesar_cambio_de_estado_en_la_tecla(evento.tecla, true)
	}
	
    def cuando_suelta_una_tecla(DataEventoTeclado evento) {
        procesar_cambio_de_estado_en_la_tecla(evento.tecla, false)
    }

    def procesar_cambio_de_estado_en_la_tecla(Tecla codigo, boolean estado) {
    	if (codigo == Tecla.IZQUIERDA) izquierda = estado
    	if (codigo == Tecla.DERECHA) derecha = estado
    	if (codigo == Tecla.ARRIBA) arriba = estado
    	if (codigo == Tecla.ABAJO) abajo = estado
    	if (codigo == Tecla.ESPACIO) boton = estado
    }

    def limpiar() {
        izquierda = false
        derecha = false
        arriba = false
        abajo = false
        boton = false
	}

}