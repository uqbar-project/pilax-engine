package org.uqbar.pilax.fondos

import com.trolltech.qt.gui.QPainter
import java.util.List
import org.uqbar.pilax.engine.Fondo
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.eventos.DataEventoMovimiento
import org.uqbar.pilax.motor.ImagenMotor
import org.uqbar.pilax.motor.PilasPainter

import static extension org.uqbar.pilax.motor.qt.QtExtensions.*
import static extension org.uqbar.pilax.utils.PilasExtensions.*

class FondoDesplazamientoHorizontal extends Fondo {
	List<Capa> capas = newArrayList
	
	new() {
		super("invisible.png")
		escena.mueveCamara.conectar(System.identityHashCode(this).toString, [d| cuandoMueveCamara(d)])
        z = 1000
	}
	
	override dibujar(PilasPainter painter) {
		painter.save
        val area = mundo.area

		capas.forEach[dibujar_tiled_horizontal(painter, area.ancho, area.alto)]

        painter.restore
	}
	
	def void agregar(String imagen, int velocidad) {
		this.agregar(imagen, 0, 0, velocidad)
	}
	
	def void agregar(String imagen, int x, int y, double velocidad) {
        val nueva_capa = new Capa(imagen, x, y, velocidad)
        capas.add(nueva_capa)
    }

    def cuandoMueveCamara(DataEventoMovimiento evento) {
    	capas.forEach[moverHorizontal(evento.delta.x)]
	}
	
	override estaFueraDeLaPantalla() {
		false
	}
	
}

class Capa {
	double x
	double y
	ImagenMotor imagen
	double velocidad
	
	new(String imagen, int x, int y, double velocidad) {
		this.imagen = Pilas.instance.mundo.motor.cargarImagen(imagen)
        this.x = x
        this.y = y
        this.velocidad = velocidad
	}
	
	def dibujar_tiled_horizontal(PilasPainter painter, double ancho, double alto) {
		painter.drawTiledPixmap(imagen.imagen, x.intValue, y.intValue, ancho.intValue, alto.intValue)
	}
    
    def moverHorizontal(double dx) {
        x = x + dx * velocidad
	}
	
}