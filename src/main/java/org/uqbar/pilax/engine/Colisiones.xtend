package org.uqbar.pilax.engine

import java.util.List
import org.eclipse.xtext.xbase.lib.Procedures.Procedure2

import static org.uqbar.pilax.engine.PythonUtils.*

import static extension org.uqbar.pilax.engine.PilasExtensions.*

/**
 * 
 */
class Colisiones {
	List<Colision> colisiones = newArrayList()
	
	def verificarColisiones() {
        for (c : colisiones)
	        c.verificar
	}
	
}

/**
 * 
 */
class Colision {
	List<Actor> grupo_a
	List<Actor> grupo_b
	Procedure2<Actor,Actor> funcion_a_llamar
	
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
}