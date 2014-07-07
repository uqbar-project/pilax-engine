package org.uqbar.pilax.motor.java2d

import java.awt.Color
import java.awt.Frame
import java.awt.Graphics
import java.awt.RenderingHints
import java.awt.event.WindowAdapter
import java.awt.event.WindowEvent
import org.uqbar.pilax.depurador.Depurador
import org.uqbar.pilax.depurador.DepuradorDeshabilitado
import org.uqbar.pilax.engine.GestorEscenas
import org.uqbar.pilax.motor.Motor
import java.awt.Graphics2D

import static extension org.uqbar.pilax.utils.PilasExtensions.*

/**
 * 
 */
class PilasFrame extends Frame {
	double originalWidth
	double originalHeight
	Depurador depurador
	Motor motor
	GestorEscenas gestorEscenas
	
	new(Motor motor, double width, double height, GestorEscenas gestorEscenas, boolean depuracion, double rendimiento) {
		this.motor = motor
		originalWidth = width
		originalHeight = height
		this.gestorEscenas = gestorEscenas
		
		depurador = /*if (depuracion)
            			new DepuradorImpl(motor.crearLienzo, fps)
			        else*/
            			new DepuradorDeshabilitado
		
		addWindowListener(new WindowAdapter() {
			override windowClosing(WindowEvent e) {
				dispose
				System.exit(0)
			}
       })
	}
	
	def paintPilas() {
		createBufferStrategy(2)
		val g = bufferStrategy.drawGraphics as Graphics2D
		
		g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
		g.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
		
		val painter = new Java2DPainter(g)
		
		val previousColor = g.color
		g.color = new Color(128, 128, 128)
		g.fillRect(0, 0, originalWidth.intValue, originalHeight.intValue)
		g.color = previousColor
        depurador.comienzaDibujado(motor, painter)

        if (gestorEscenas.escenaActual != null) {
            for (actor : gestorEscenas.escenaActual.actores.copy) {
                try {
                    if (!actor.estaFueraDeLaPantalla)
                        actor.dibujar(painter)
         		}
                catch (RuntimeException e) {
                    e.printStackTrace
                    actor.eliminar
                }

                depurador.dibujaAlActor(motor, painter, actor)
			}
		}
		g.dispose
		bufferStrategy.show
        depurador.terminaDibujado(motor, painter)
	}
	
	override paintComponents(Graphics g) {
		super.paintComponents(g)
	}
	
	def createPainter() {
		new Java2DPainter(graphics)
	}
}