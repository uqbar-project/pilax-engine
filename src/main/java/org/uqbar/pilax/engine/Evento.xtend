package org.uqbar.pilax.engine

import com.trolltech.qt.core.Qt.MouseButton
import java.util.Map

class Evento {
	@Property Map<String, HandlerEvento> respuestas
    @Property String nombre
    
    // solo para los de teclado!
    @Property Integer codigo
	
	new(String nombre) {
        this.nombre = nombre
        this.respuestas = newHashMap()
	}
	//codigo=codigo_de_tecla, es_repeticion=event.isAutoRepeat(), texto=event.text())
	def emitir(Object codigo, boolean es_repeticion, String texto) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def emitir() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def emitir(float x, float y, float dx, float dy) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def emitir(float x, float y, float dx, float dy, MouseButton botonPulsado) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def emitir(float delta) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def desconectar(HandlerEvento respuesta) {
        try {
            this.respuestas.remove(respuesta)
        }
        catch(Exception e) {
            throw new RuntimeException("La funcion indicada no estaba agregada como respuesta del evento.")
        }
    }
	
	def desconectarPorId(String id) {
        val a_eliminar = newArrayList
        for (respuesta : this.respuestas.entrySet) {
            if (respuesta.key == id)
                a_eliminar.add(respuesta.value)
        }

        for (x : a_eliminar)
            this.desconectar(x)
	}
	
	def conectar(String id, HandlerEvento respuesta) {
		this.respuestas.put(id, respuesta)
//        if inspect.isfunction(respuesta):
//            self.respuestas.add(ProxyFuncion(respuesta, id))
//        elif inspect.ismethod(respuesta):
//            self.respuestas.add(ProxyMetodo(respuesta, id))
//        else:
//            raise ValueError("Solo se permite conectar nombres de funciones o metodos.")
    }
	
}