package org.uqbar.pilax.actores.interfaz

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Pilas

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*
import org.uqbar.pilax.motor.Superficie
import java.awt.Color
import org.uqbar.pilax.motor.ImagenMotor

class Pizarra extends Actor implements Canvas {
	
	new(double x, double y) {
		this(x,y, anchoMundo(), altoMundo())
	}
	
	def static anchoMundo() { Pilas.instance.mundo.area.ancho }
	def static altoMundo() { Pilas.instance.mundo.area.alto }
	
	new(double x, double y, double ancho, double alto) {
		super("invisible.png", x, y)
        self.imagen = new Superficie(ancho, alto)
	}
	
	override Superficie getImagen() {
		imagen as Superficie
	}
	
	def dibujar_punto(double x, double y, Color color) {
		val coord = obtener_coordenada_fisica(x, y);
        imagen.dibujarPunto(coord.x, coord.y, color)
	}
	
	def obtener_coordenada_fisica(double x, double y) {
		(imagen.ancho / 2) + x  ->	(self.imagen.alto / 2) - y   
	}
	
	override pintar_parte_de_imagen(ImagenMotor imagen, double origen_x, double origen_y, double ancho, double alto, double x, double y) {
        val coord = obtener_coordenada_fisica(x, y)
        this.imagen.pintar_parte_de_imagen(imagen, origen_x, origen_y, ancho, alto, coord.x, coord.y)
    }

}