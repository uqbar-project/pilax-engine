package org.uqbar.pilax.motor.java2d

import java.awt.image.BufferedImage
import java.util.Timer
import org.uqbar.pilax.engine.GestorEscenas
import org.uqbar.pilax.engine.Mundo

import static extension org.uqbar.pilax.motor.java2d.Java2DExtensions.*
import org.uqbar.pilax.motor.qt.FPS

/**
 * Implementacion del Motor usando java2d
 * 
 * @author jfernandes
 */
class MotorJava2D extends AbstractMotor {
	PilasFrame frame
	int fps
	FPS fpsCounter
	
	new() {
		System.setProperty("sun.java2d.opengl","True");
	}
	
	override iniciarVentana(int ancho, int alto, String titulo, boolean pantalla_completa, GestorEscenas gestor, float rendimiento) {
		anchoOriginal = ancho
		altoOriginal = alto
		gestorEscenas = gestor
		fps = rendimiento.intValue
		fpsCounter = new FPS(fps, false)
		frame = new PilasFrame(this, ancho, alto, gestor, false, rendimiento) => [
			size = (ancho -> alto).toDimension
			title = titulo
		]
	}
	
	Object lock = new Object
	
	override ejecutarBuclePrincipal(Mundo mundo) {
		val timer = new Timer
		timer.schedule([| frame.paintPilas], 0, 1000 / fps)
		timer.schedule([| realizarActualizacionLogica ], 0, 1000 / 100)
		val a = synchronized(lock) {
			lock.wait
			42
		}
	}
	
	// DUMMY
	override fps() { fpsCounter }
	override pausaHabilitada() { false }
	
	override visible() { frame.visible = true }
	override terminar() { 
		frame.visible = false
		val a = synchronized(lock) {
			lock.notify
			42
		}
	}
	override getAncho() { frame.width }

	override loadImage(String fullPath) { new Java2DImage(fullPath) }
	
	override createImage(int width, int height) {
		new Java2DImage(new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB))
	}
	
	override createPainter() { frame.createPainter() }
	
	override obtenerAreaDeTexto(String texto, int magnitud, boolean vertical, String fuente) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	
	
}