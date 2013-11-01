package org.uqbar.pilax.engine

import java.util.Map

import static extension org.uqbar.pilax.engine.PythonUtils.*

class Control {
	@Property boolean izquierda
	@Property boolean derecha
	@Property boolean arriba
	@Property boolean abajo
	@Property boolean boton 
	Map<Integer,String> mapa_teclado
	
	new(EscenaBase escena, Map<Integer,String> mapa_teclado) {
        escena.pulsaTecla.conectar("control", [data| cuando_pulsa_una_tecla(data) ])
        escena.sueltaTecla.conectar("control", [data| cuando_suelta_una_tecla(data) ])
        
        if (mapa_teclado == None)
        	// mapa <int:codigo tecla -> string: nombre property de esta instancia a invocar!
            self.mapa_teclado = #{Simbolos.IZQUIERDA ->'izquierda',
                                  Simbolos.DERECHA -> 'derecha',
                                  Simbolos.ARRIBA -> 'arriba',
                                  Simbolos.ABAJO -> 'abajo',
                                  Simbolos.ESPACIO -> 'boton'}
        else
            self.mapa_teclado = mapa_teclado
    }

    def cuando_pulsa_una_tecla(DataEvento evento) {
        self.procesar_cambio_de_estado_en_la_tecla((evento as DataEventoTeclado).codigoDeTecla, true)
	}
	
    def cuando_suelta_una_tecla(DataEvento evento) {
        self.procesar_cambio_de_estado_en_la_tecla((evento as DataEventoTeclado).codigoDeTecla, false)
    }

    def procesar_cambio_de_estado_en_la_tecla(Object codigo, boolean estado) {
        if (self.mapa_teclado.containsKey(codigo)) {
            setattr(self, self.mapa_teclado.get(codigo), estado)
        }
    }

    def limpiar() {
        self.izquierda = False
        self.derecha = False
        self.arriba = False
        self.abajo = False
        self.boton = False
	}
	

}