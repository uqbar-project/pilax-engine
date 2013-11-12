package org.uqbar.pilax.actores.interfaz

import java.awt.Color
import org.uqbar.pilax.actores.ActorTexto
import org.uqbar.pilax.actores.PosicionCentro
import org.eclipse.xtext.xbase.lib.Procedures.Procedure0

class ActorOpcion extends ActorTexto {
	Procedure0 funcion_a_invocar
	Color color_normal
	Color color_resaltado
	
	new(String texto, double x, double y, Procedure0 function, String fuente, Color colorNormal, Color colorResaltado) {
		super(texto, x.intValue, y.intValue, fuente)
        magnitud = 20
        funcion_a_invocar = function
        color_normal = colorNormal
        color_resaltado = colorResaltado
        color = colorNormal
        z = -300
        centroRelativo = PosicionCentro.centrada
	}
	
	def resaltar() {
		resaltar(true)
	}
	
	def resaltar(boolean estado) {
		color = if (estado) color_resaltado else color_normal 
	}
	
	def seleccionar() {
		funcion_a_invocar.apply
    }
}