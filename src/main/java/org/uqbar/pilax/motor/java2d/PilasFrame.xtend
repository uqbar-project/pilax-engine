package org.uqbar.pilax.motor.java2d

import java.awt.Color
import java.awt.Frame
import java.awt.Graphics
import java.awt.Graphics2D
import java.awt.RenderingHints
import java.awt.event.KeyEvent
import java.awt.event.KeyListener
import java.awt.event.MouseEvent
import java.awt.event.MouseListener
import java.awt.event.MouseMotionListener
import java.awt.event.WindowAdapter
import java.awt.event.WindowEvent
import org.uqbar.pilax.depurador.Depurador
import org.uqbar.pilax.depurador.DepuradorDeshabilitado
import org.uqbar.pilax.engine.GestorEscenas
import org.uqbar.pilax.eventos.DataEvento
import org.uqbar.pilax.eventos.DataEventoMouse
import org.uqbar.pilax.eventos.DataEventoTeclado
import org.uqbar.pilax.eventos.Evento
import org.uqbar.pilax.eventos.MouseButton
import org.uqbar.pilax.motor.Motor

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.Utils.*
import org.uqbar.pilax.engine.Tecla

/**
 * 
 */
class PilasFrame extends Frame implements MouseListener, MouseMotionListener, KeyListener {
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
       addKeyListener(this)
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
	
	// key listener
	
	override keyPressed(KeyEvent event) {
		// Se mantiene este lanzador de eventos por la clase Control
        if (event.escape) eventos.pulsaTeclaEscape.emitir(new DataEvento)
//        if (event.pausa) alternarPausa
//        if (event.fullScreen) alternarPantallaCompleta

        val codigo_de_tecla = event.keyCode.toTeclaPilas
        eventos.pulsaTecla.emitir(new DataEventoTeclado(codigo_de_tecla, false /*event.isAutoRepeat*/, String.valueOf(event.keyChar)))
        depurador.cuandoPulsaTecla(codigo_de_tecla, event.keyChar)
	}
	
	def toTeclaPilas(int code) {
		switch code {
			// direcciones
			case KeyEvent.VK_DOWN: Tecla.ABAJO
			case KeyEvent.VK_UP: Tecla.ARRIBA
			case KeyEvent.VK_LEFT: Tecla.IZQUIERDA
			case KeyEvent.VK_RIGHT: Tecla.DERECHA
			// letras
			case KeyEvent.VK_A: Tecla.a
			case KeyEvent.VK_B: Tecla.b
			case KeyEvent.VK_C: Tecla.c
			case KeyEvent.VK_D: Tecla.d
			case KeyEvent.VK_E: Tecla.e
			case KeyEvent.VK_F: Tecla.f
			case KeyEvent.VK_G: Tecla.g
			case KeyEvent.VK_H: Tecla.h
			case KeyEvent.VK_I: Tecla.i
			case KeyEvent.VK_J: Tecla.j
			case KeyEvent.VK_K: Tecla.k
			case KeyEvent.VK_M: Tecla.m
			case KeyEvent.VK_N: Tecla.n
			case KeyEvent.VK_O: Tecla.o
			case KeyEvent.VK_P: Tecla.p
			case KeyEvent.VK_Q: Tecla.q
			case KeyEvent.VK_R: Tecla.r
			case KeyEvent.VK_S: Tecla.s
			case KeyEvent.VK_T: Tecla.t
			case KeyEvent.VK_U: Tecla.u
			case KeyEvent.VK_V: Tecla.v
			case KeyEvent.VK_W: Tecla.w
			case KeyEvent.VK_X: Tecla.x
			case KeyEvent.VK_Y: Tecla.y
			case KeyEvent.VK_Z: Tecla.z
			// f's
			case KeyEvent.VK_F1: Tecla.F1
			case KeyEvent.VK_F2: Tecla.F2
			case KeyEvent.VK_F3: Tecla.F3
			case KeyEvent.VK_F4: Tecla.F4
			case KeyEvent.VK_F5: Tecla.F5
			case KeyEvent.VK_F6: Tecla.F6
			case KeyEvent.VK_F7: Tecla.F7
			case KeyEvent.VK_F8: Tecla.F8
			case KeyEvent.VK_F9: Tecla.F9
			case KeyEvent.VK_F10: Tecla.F10
			case KeyEvent.VK_F11: Tecla.F11
			case KeyEvent.VK_F12: Tecla.F12
		}
	}
	
	def isEscape(KeyEvent event) { event.keyCode == KeyEvent.VK_ESCAPE }
	def isPausa(KeyEvent event) { event.keyCode == KeyEvent.VK_PAUSE }
	def isFullScreen(KeyEvent event) { event.keyCode == KeyEvent.VK_F && event.altDown }
	
	override keyReleased(KeyEvent event) {
		val codigo_de_tecla = event.keyCode.toTeclaPilas
        // Se mantiene este lanzador de eventos por la clase Control
        eventos.sueltaTecla.emitir(new DataEventoTeclado(codigo_de_tecla, false /* event.isAutoRepeat */, String.valueOf(event.keyChar)))
	}
	
	override keyTyped(KeyEvent e) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}