package org.uqbar.pilax.actores

import java.awt.Color
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Colores
import org.uqbar.pilax.motor.Superficie
import org.uqbar.pilax.utils.Utils

class ActorTextoInferior extends ActorTexto {
	static ActorTextoInferior anterior_texto
	
	Actor sombra
	
	new(String texto, int x, int y, boolean auto_eliminar, int retraso) {
		super(texto, x, y)
        val bordes = Utils.bordes

        // Se asegura de que solo exista un texto inferior
        if (anterior_texto != null)
            anterior_texto.eliminar

        z = -100
        anterior_texto = this
        _crear_sombra()

        centroRelativo = centrada()
        izquierda = bordes.izquierda + 10
        color = Color.white
        abajo = bordes.abajo + 10
        fijo = true

        if (auto_eliminar)
            escena.tareas.unaVez(retraso, [| eliminar ])
		
	}
	
	def _crear_sombra() {
        /** Genera una sombra para el texto.*/
        val bordes = Utils.bordes
        val imagen = new Superficie(bordes.derecha - bordes.izquierda, 40)
        imagen.pintar(Colores.negroTransparente)

        sombra = new Actor(imagen)
        sombra.z = z + 1
        sombra.fijo = true
        sombra.abajo = bordes.abajo
        sombra.izquierda = bordes.izquierda
	}
	
	override eliminar() {
		super.eliminar
        sombra.eliminar
	}
	
}