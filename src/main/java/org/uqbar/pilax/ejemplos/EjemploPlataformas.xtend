package org.uqbar.pilax.ejemplos

import org.uqbar.pilax.actores.Mapa
import org.uqbar.pilax.engine.Pelota
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.motor.GrillaImagen
import org.uqbar.pilax.utils.Utils

class EjemploPlataformas {
	def static void main(String[] args) {
		Pilas.iniciar
		val mapa = new Mapa(new GrillaImagen("grillas/plataformas_10_10.png", 10, 10), 20, 20);
		mapa.pintar_bloque(10, 10, 0, true)
		mapa.pintar_bloque(10, 11, 1, true)
		mapa.pintar_bloque(10, 12, 1, true)
		mapa.pintar_bloque(10, 13, 1, true)
		mapa.pintar_bloque(10, 14, 2, true)
		
		mapa.pintar_bloque(10, 0, 0, true)
		mapa.pintar_bloque(10, 1, 1, true)
		mapa.pintar_bloque(10, 2, 1, true)
		mapa.pintar_bloque(10, 3, 1, true)
		mapa.pintar_bloque(10, 4, 2, true)
		
		val pelotas = Utils.fabricar(Pelota, 1)

		Pilas.instance.avisar("Creando dos plataformas solidas...")
		Pilas.instance.ejecutar
	}
	
}