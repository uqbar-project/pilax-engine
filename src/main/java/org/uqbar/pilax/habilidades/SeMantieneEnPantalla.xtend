package org.uqbar.pilax.habilidades

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Habilidad
import org.uqbar.pilax.engine.Pilas
import org.eclipse.xtext.xbase.lib.Pair

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class SeMantieneEnPantalla extends Habilidad {
	Pair<Double,Double> area
	@Property boolean permitir_salida = true
	
	new(Actor receptor) {
		super(receptor)
		area = Pilas.instance.mundo.area
	}
	
	override actualizar() {
		if (permitir_salida) {
            // Se asegura de regresar por izquierda y derecha.
            if (receptor.derecha < -(area.ancho/2))
                receptor.izquierda = (area.ancho/2)
            else if (receptor.izquierda > (area.ancho/2))
                receptor.derecha = -(area.ancho/2)

            // Se asegura de regresar por arriba y abajo.
            if (receptor.abajo > (area.alto/2))
                receptor.arriba = -(area.alto/2)
            else if (receptor.arriba < -(area.alto/2))
                receptor.abajo = (area.alto/2)
        }
        else {
            if (receptor.izquierda <= -(area.ancho/2))
                receptor.izquierda = -(area.ancho/2)
            else if (receptor.derecha >=  (area.ancho/2))
                receptor.derecha = area.ancho/2

            if (receptor.arriba > (area.alto/2))
                receptor.arriba = (area.alto/2)
            else if (receptor.abajo < -(area.alto/2))
                receptor.abajo = -(area.alto/2)
        }
	}
	
}