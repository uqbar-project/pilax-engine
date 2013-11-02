package org.uqbar.pilax.ejemplos

import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.actores.Mono
import org.uqbar.pilax.habilidades.SeguirAlMouse
import org.uqbar.pilax.habilidades.MoverseConTeclado
import com.trolltech.qt.core.Qt

class EjemploMono {
	
	def static void main(String[] args) {
		Pilas.iniciar
		
		print(Qt.Key.Key_Left.value)
		
		val mono = new Mono()
//		mono.aprender(SeguirAlMouse)
		mono.aprender(MoverseConTeclado)
		
		Pilas.instance.ejecutar
	}
	
}