package org.uqbar.pilax.motor.java2d

import java.awt.image.BufferedImage
import org.uqbar.pilax.engine.GestorEscenas
import org.uqbar.pilax.engine.Mundo

import static extension org.uqbar.pilax.motor.java2d.Java2DExtensions.*
import java.util.concurrent.ExecutorService
import java.util.Timer

/**
 * Implementacion del Motor usando java2d
 * 
 * @author jfernandes
 */
class MotorJava2D extends AbstractMotor {
	PilasFrame frame
	int fps
	
	override iniciarVentana(int ancho, int alto, String titulo, boolean pantalla_completa, GestorEscenas gestor, float rendimiento) {
		anchoOriginal = ancho
		altoOriginal = alto
		fps = rendimiento.intValue
		frame = new PilasFrame(this, ancho, alto, gestor, false, rendimiento) => [
			size = (ancho -> alto).toDimension
			title = titulo
		]
	}
	
	override ejecutarBuclePrincipal(Mundo mundo) {
		val timer = new Timer
		timer.schedule([| frame.repaint], 0, 1000 / fps)
	}
	
	override visible() { frame.visible = true }
	override terminar() { frame.visible = false }
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