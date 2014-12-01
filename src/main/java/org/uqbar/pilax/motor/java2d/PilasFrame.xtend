package org.uqbar.pilax.motor.java2d

import java.awt.Color
import java.awt.Frame
import java.awt.Graphics
import java.awt.Graphics2D
import java.awt.RenderingHints
import java.awt.event.MouseEvent
import java.awt.event.MouseListener
import java.awt.event.WindowAdapter
import java.awt.event.WindowEvent
import org.uqbar.pilax.depurador.Depurador
import org.uqbar.pilax.depurador.DepuradorDeshabilitado
import org.uqbar.pilax.engine.GestorEscenas
import org.uqbar.pilax.eventos.DataEventoMouse
import org.uqbar.pilax.eventos.Evento
import org.uqbar.pilax.eventos.MouseButton
import org.uqbar.pilax.motor.Motor

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.Utils.*
import java.awt.event.MouseMotionListener

/**
 * 
 */
class PilasFrame extends Frame implements MouseListener, MouseMotionListener {
	double originalWidth
	double originalHeight
	double escala = 1.0
	Pair<Double,Double> mouse
	Depurador depurador
	Motor motor
	GestorEscenas gestorEscenas
	
	new(Motor motor, double width, double height, GestorEscenas gestorEscenas, boolean depuracion, double rendimiento) {
		this.motor = motor
		originalWidth = width
		originalHeight = height
		this.gestorEscenas = gestorEscenas
		mouse = origen
		
		depurador = /*if (depuracion)
            			new DepuradorImpl(motor.crearLienzo, fps)
			        else*/
            			new DepuradorDeshabilitado
		addMouseListener(this)
		
		addWindowListener(new WindowAdapter() {
			override windowClosing(WindowEvent e) {
				dispose
				System.exit(0)
			}
       })
       addMouseMotionListener(this)
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
	
	// mouse listener
	
	override mouseClicked(MouseEvent e) {
		triggerearEventoDeMouseClick(e, gestorEscenas.escenaActual.clickDeMouse)
	}
	
	override mousePressed(MouseEvent e) {
		triggerearEventoDeMouseClick(e, gestorEscenas.escenaActual.clickDeMouse)
	}
	
	override mouseReleased(MouseEvent e) {
		triggerearEventoDeMouseClick(e, gestorEscenas.escenaActual.terminaClick)
	}
	
	override mouseEntered(MouseEvent e) {
	}
	
	override mouseExited(MouseEvent e) {
		//todo
	}
	
	def protected triggerearEventoDeMouseClick(MouseEvent e, Evento<DataEventoMouse> evento) {
		val posRelativa = ((e.XOnScreen.doubleValue -> e.YOnScreen.doubleValue) / escala).aRelativa
		val d = new DataEventoMouse(posRelativa, origen(), e.button.toPilasButton)
        evento.emitir(d)
	}
	
	def toPilasButton(int java2dbutton) {
		switch java2dbutton {
			case MouseEvent.BUTTON1 : MouseButton.LEFT
			case MouseEvent.BUTTON2 : MouseButton.RIGHT
			case MouseEvent.BUTTON3 : MouseButton.MIDDLE
			default : MouseButton.LEFT
		}
	}
	
	def Pair<Double,Double> operator_divide(Pair<Double,Double> pair, Double d) {
		(pair.x / d -> pair.y / d)
	}
	
	override mouseDragged(MouseEvent e) {
	}
	
	override mouseMoved(MouseEvent e) {
		var posRelativa = ((e.XOnScreen.doubleValue -> e.YOnScreen.doubleValue) / escala).aRelativa + motor.centroDeLaCamara
        gestorEscenas.escenaActual.mueveMouse.emitir(new DataEventoMouse(posRelativa, posRelativa - mouse, null))
		mouse = posRelativa
        depurador.cuandoMueveElMouse(x.intValue, y.intValue)
	}
	
}