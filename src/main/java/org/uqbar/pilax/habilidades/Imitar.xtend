package org.uqbar.pilax.habilidades

import org.uqbar.pilax.comunes.ObjetoGrafico
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Habilidad
import org.uqbar.pilax.fisica.Figura

class Imitar extends Habilidad {
	@Property ObjetoGrafico objetoAImitar
	@Property boolean conRotacion = true
	
	new(Actor receptor) {
		super(receptor)
	}

	def void setObjetoAImitar(ObjetoGrafico aImitar) {
		receptor.id = aImitar.id
//         Y nos guardamos una referencia al objeto físico al que imita.
//         Posterormente en las colisiones fisicas comprobaremos si el
//         objeto tiene el atributo "figura" para saber si estamos delante
//         de una figura fisica o no.
        receptor.figura = aImitar
        _objetoAImitar = aImitar
	}	
	
	override actualizar() {
		receptor.x = objetoAImitar.x
        receptor.y = objetoAImitar.y
        if (conRotacion) {
            receptor.rotacion = objetoAImitar.rotacion
        }
	}
	
	override eliminar() {
       if (objetoAImitar instanceof Figura)
           (objetoAImitar as Figura).eliminar
	}
	
}