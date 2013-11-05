package org.uqbar.pilax.eventos

import java.util.HashSet
import java.util.Map

import static extension org.uqbar.pilax.utils.PilasExtensions.*

// Esto sería más acertado llamarlo TipoEvento o luego tener InstanciaEvento como 
// una en particular con sus datos.
class Evento<D extends DataEvento> {
	@Property Map<String, HandlerEvento<D>> respuestas
    @Property String nombre
    
	new(String nombre) {
        this.nombre = nombre
        this.respuestas = newHashMap()
	}

	def emitir(D data) {
		[|
			val a_eliminar = newArrayList
	        for (respuesta : new HashSet(respuestas.values)) {
	            try {
					respuesta.manejar(data)
	            }
	            catch (Exception e) {
	            	e.printStackTrace
	                a_eliminar.add(respuesta)
	            }
	        }
			a_eliminar.forEach[desconectar(it)]
		].execAsync
	}
	
	def desconectar(HandlerEvento<D> respuesta) {
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
	
	def conectar(String id, HandlerEvento<D> respuesta) {
		this.respuestas.put(id, respuesta)
//        if inspect.isfunction(respuesta):
//            self.respuestas.add(ProxyFuncion(respuesta, id))
//        elif inspect.ismethod(respuesta):
//            self.respuestas.add(ProxyMetodo(respuesta, id))
//        else:
//            raise ValueError("Solo se permite conectar nombres de funciones o metodos.")
    }
	
}