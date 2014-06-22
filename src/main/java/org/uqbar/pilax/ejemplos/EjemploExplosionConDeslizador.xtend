package org.uqbar.pilax.ejemplos

import java.awt.Color
import org.uqbar.pilax.actores.ActorTexto
import org.uqbar.pilax.actores.animacion.ActorAnimacion
import org.uqbar.pilax.actores.interfaz.Deslizador
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.motor.GrillaImagen

class EjemploExplosionConDeslizador {
	static ActorAnimacion animacion
	static ActorTexto texto
	
	def static void main(String[] args) {
		Pilas.iniciar

		val grilla = new GrillaImagen("explosion.png", 7, 1)
		animacion = new ActorAnimacion(grilla, 0, 0, true, 1)

		texto = new ActorTexto("1 cuadro por segundo", 100, 80) => [ magnitud=10 ]
		texto.color = Color.black
		
		val barra = new Deslizador() => [ y = 100 ]
		barra.conectar([p| cambia_velocidad(p)])
		
		Pilas.instance.avisar("Usa la barra para modificar la velocidad de la animacion.")
		Pilas.instance.ejecutar
	}
	
	def static cambia_velocidad(double prog) {
		val progreso = (1 + prog * 60).intValue
		animacion.velocidad_de_animacion = progreso
		texto.texto = progreso + " cuadros por segundo"
	}
	
}
