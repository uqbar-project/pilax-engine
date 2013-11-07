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
	
}

/**
 * 
 */
class Colision {
	@Property List<Actor> grupo_a
	@Property List<Actor> grupo_b
	@Property Procedure2<Actor,Actor> funcion_a_llamar
	
	def verificar() {
		for (a : grupo_a) {
            for (b : grupo_b) {
                try {
                    if (id(a) != id(b) && Utils.colisionan(a, b)) {
                        funcion_a_llamar.apply(a, b)
                    }

                    // verifica si alguno de los dos objetos muere en la colision.
                    if (!a.esActor) {
                        if (grupo_a.contains(a))
                            grupo_a.remove(a)
                    }

                    if (!b.esActor)
                        if (grupo_b.contains(b))
                            grupo_b.remove(b)
                }
                catch (RuntimeException e) {
                    grupo_a.remove(a)
                    throw e
                }
			}
		}
	}
	
	def verificarColisionesFisicasEnTupla(UUID id_actor_a, UUID id_actor_b) {
        /** Toma dos grupos de actores y analiza colisiones entre ellos.*/
        for (a : grupo_a) {
            for (b : grupo_b) {
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
                        this.funcion_a_llamar.apply(a, b)

                        // verifica si alguno de los dos objetos muere en la colision.
                        if (_es_objeto_fisico_con_actor_asociado(a))
                            if (!a.esActor)
                                if (a.in(grupo_a))
                                    grupo_a.remove(a)

						if (_es_objeto_fisico_con_actor_asociado(b))
                            if (!b.esActor)
                                if (b.in(grupo_a))
                                    grupo_b.remove(b)
                    }
				}
                catch (RuntimeException e) {
                    grupo_a.remove(a)
                    throw e
                }
            }
        }
    }
    
    def _es_objeto_fisico_con_actor_asociado(Actor actor) {
        return actor.figura != null
    }
    
}