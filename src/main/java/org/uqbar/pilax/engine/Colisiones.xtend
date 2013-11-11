package org.uqbar.pilax.engine

import java.util.List
import java.util.UUID
import org.eclipse.xtext.xbase.lib.Procedures.Procedure2
import org.uqbar.pilax.utils.Utils

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

/**
 * 
 */
class Colisiones {
	List<Colision> colisiones = newArrayList()
	
	def verificarColisiones() {
        for (c : colisiones)
	        c.verificar
	}
	
	def verificarColisionesFisicas(UUID idActorA, UUID idActorB) {
        colisiones.forEach[ verificarColisionesFisicasEnTupla(idActorA, idActorB)]
	}
	
	def <A extends Actor, B extends Actor> void agregar(A a, List<B> grupo_b, Procedure2<A,B> funcion_a_llamar) {
		agregar(a.asList, grupo_b, funcion_a_llamar)
	}
	
	def <A extends Actor, B extends Actor> void agregar(A a, B b, Procedure2<A,B> funcion_a_llamar) {
		agregar(a.asList, b.asList, funcion_a_llamar)
	}
	
	def <A extends Actor, B extends Actor> void agregar(List<A> grupo_a, B b, Procedure2<A,B> funcion_a_llamar) {
		agregar(grupo_a, b.asList, funcion_a_llamar)
	}
	
	/** Agrega dos listas de actores para analizar colisiones.*/
	def <A extends Actor, B extends Actor> agregar(List<A> grupo_a, List<B> grupo_b, Procedure2<A,B> funcion_a_llamar) {
        colisiones.add(new Colision(grupo_a, grupo_b, funcion_a_llamar))
	}
}

/**
 * 
 */
class Colision<A extends Actor, B extends Actor> {
	@Property List<A> grupoA
	@Property List<B> grupoB
	@Property Procedure2<A,B> funcion
	
	new(List<A> grupo_a, List<B> grupo_b, Procedure2<A,B> funcion) {
		this.grupoA = grupo_a
		this.grupoB = grupo_b
		this.funcion = funcion
	} 
	
	def verificar() {
		for (a : grupoA.copy) {
            for (b : grupoB.copy) {
                try {
                    if (id(a) != id(b) && Utils.colisionan(a, b)) {
                        funcion.apply(a, b)
                    }

                    // verifica si alguno de los dos objetos muere en la colision.
                    if (!a.esActor) {
                        if (grupoA.contains(a))
                            grupoA.remove(a)
                    }

                    if (!b.esActor)
                        if (grupoB.contains(b))
                            grupoB.remove(b)
                }
                catch (RuntimeException e) {
                    grupoA.remove(a)
                    throw e
                }
			}
		}
	}
	
	def verificarColisionesFisicasEnTupla(UUID id_actor_a, UUID id_actor_b) {
        /** Toma dos grupos de actores y analiza colisiones entre ellos.*/
        for (a : grupoA) {
            for (b : grupoB) {
                try {
                	val a_id = if (_es_objeto_fisico_con_actor_asociado(a))
                        			a.figura.id
                    			else
                        			a.id

					val b_id = if (_es_objeto_fisico_con_actor_asociado(b)) 
                        			b.figura.id
                    			else
                        			b.id

                    if (a_id == id_actor_a && b_id == id_actor_b) {
                        this.funcion.apply(a, b)

                        // verifica si alguno de los dos objetos muere en la colision.
                        if (_es_objeto_fisico_con_actor_asociado(a))
                            if (!a.esActor)
                                if (grupoA.contains(a))
                                    grupoA.remove(a)

						if (_es_objeto_fisico_con_actor_asociado(b))
                            if (!b.esActor)
                                if (grupoB.contains(b))
                                    grupoB.remove(b)
                    }
				}
                catch (RuntimeException e) {
                    grupoA.remove(a)
                    throw e
                }
            }
        }
    }
    
    def _es_objeto_fisico_con_actor_asociado(Actor actor) {
        return actor.figura != null
    }
    
}