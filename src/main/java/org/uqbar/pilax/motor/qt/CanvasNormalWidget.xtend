package org.uqbar.pilax.motor.qt

import com.trolltech.qt.core.QTimerEvent
import com.trolltech.qt.core.Qt
import com.trolltech.qt.gui.QColor
import com.trolltech.qt.gui.QKeyEvent
import com.trolltech.qt.gui.QMouseEvent
import com.trolltech.qt.gui.QPaintEvent
import com.trolltech.qt.gui.QPainter
import com.trolltech.qt.gui.QWheelEvent
import com.trolltech.qt.gui.QWidget
import com.trolltech.qt.opengl.QGLWidget
import java.util.List
import org.uqbar.pilax.actores.ActorPausa
import org.uqbar.pilax.depurador.Depurador
import org.uqbar.pilax.depurador.DepuradorDeshabilitado
import org.uqbar.pilax.depurador.DepuradorImpl
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.GestorEscenas
import org.uqbar.pilax.engine.PilaxException
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.eventos.DataEvento
import org.uqbar.pilax.eventos.DataEventoMouse
import org.uqbar.pilax.eventos.DataEventoRuedaMouse
import org.uqbar.pilax.eventos.DataEventoTeclado
import org.uqbar.pilax.eventos.Evento

import static extension org.uqbar.pilax.motor.qt.QtExtensions.*
import static extension org.uqbar.pilax.utils.PilasExtensions.*

class CanvasNormalWidget extends QGLWidget /*QWidget */  {
	QTPilasPainter painter
	@Property boolean pausaHabilitada
	Pair<Double,Double> mouse
	MotorQT motor
	List<Actor> listaActores
	@Property FPS fps
	double escala
	//capaz es de QWidget
	double original_width
	double original_height
	Depurador depurador
	GestorEscenas gestorEscenas
	ActorPausa actorPausa
	
	new(MotorQT motor, List<Actor> lista_actores, double ancho, double alto, GestorEscenas gestor_escenas, boolean permitir_depuracion, double rendimiento) {
		super(null as QWidget)
//        this.painter = new QPainter()
        mouseTracking = true
        pausaHabilitada = false
        mouse = origen
        this.motor = motor
        listaActores = lista_actores
        fps = new FPS(rendimiento, true)

		depurador = if (permitir_depuracion)
            			new DepuradorImpl(motor.crearLienzo, fps)
			        else
            			new DepuradorDeshabilitado

        original_width = ancho
        original_height = alto
        escala = 1
        startTimer(1000/100)
        gestorEscenas = gestor_escenas
    }

    def resize_to(double new_width, double new_height) {
    	val relacion = new_width / original_width -> new_height / original_height 
        this.escala = relacion.min

        val final_w = original_width * escala
        val final_h = original_height * escala
        
        val x = new_width - final_w
        val y = new_height - final_h

        setGeometry(x.intValue / 2, y.intValue / 2, final_w.intValue, final_h.intValue)
	}
	
	override protected paintEvent(QPaintEvent event) {
		//PILAX ( tuve que mover esto para que genere un nuevo painter cada
		// vez, sino me fallaba. En pilas no es así! :(
		painter = new QTPilasPainter(new QPainter)
		painter.QPainter.begin(this)

        painter.QPainter.scale(escala)

		painter.QPainter.setRenderHints(new QPainter.RenderHints(QPainter.RenderHint.Antialiasing,
        			QPainter.RenderHint.HighQualityAntialiasing,
        			QPainter.RenderHint.SmoothPixmapTransform));

        painter.QPainter.fillRect(0, 0, original_width.intValue, original_height.intValue, new QColor(128, 128, 128))
        depurador.comienzaDibujado(motor, painter)

        if (gestorEscenas.escenaActual != null) {
            for (actor : gestorEscenas.escenaActual.actores) {
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
        depurador.terminaDibujado(motor, painter)
        painter.end
	}
	
	override protected timerEvent(QTimerEvent event) {
//		[|
	        try {
	            motor.realizarActualizacionLogica
		    }
	        catch(RuntimeException e) {
	        	e.printStackTrace
	        }
//        ].execAsync
        update
    }
    	
	override protected mouseMoveEvent(QMouseEvent e) {
        var posRelativa = (e.pos / escala).aRelativa + motor.centroDeLaCamara
        gestorEscenas.escenaActual.mueveMouse.emitir(new DataEventoMouse(posRelativa, posRelativa - mouse, null))
		mouse = posRelativa
        depurador.cuandoMueveElMouse(x.intValue, y.intValue)
	}
	
	override protected keyPressEvent(QKeyEvent event) {
        // Se mantiene este lanzador de eventos por la clase Control
        if (event.escape) eventos.pulsaTeclaEscape.emitir(new DataEvento)
        if (event.pausa) alternarPausa
        if (event.fullScreen) alternarPantallaCompleta

        val codigo_de_tecla = _obtener_codigo_de_tecla_normalizado(event.key())
        eventos.pulsaTecla.emitir(new DataEventoTeclado(codigo_de_tecla, event.isAutoRepeat, event.text))
        depurador.cuandoPulsaTecla(codigo_de_tecla, event.text())
    }
    
	override protected keyReleaseEvent(QKeyEvent event) {
        val codigo_de_tecla = _obtener_codigo_de_tecla_normalizado(event.key())
        // Se mantiene este lanzador de eventos por la clase Control
        eventos.sueltaTecla.emitir(new DataEventoTeclado(codigo_de_tecla, event.isAutoRepeat, event.text))
    }
    
	override protected wheelEvent(QWheelEvent e) {
        gestorEscenas.escenaActual.mueveRueda.emitir(new DataEventoRuedaMouse(e.delta / 120))
	}
	
	override protected mousePressEvent(QMouseEvent e) {
		triggerearEventoDeMouseClick(e, gestorEscenas.escenaActual.clickDeMouse)
	}
	
	override protected mouseReleaseEvent(QMouseEvent e) {
		triggerearEventoDeMouseClick(e, gestorEscenas.escenaActual.terminaClick)        
    }
    
    def protected triggerearEventoDeMouseClick(QMouseEvent e, Evento<DataEventoMouse> evento) {
		val posRelativa = (e.pos / escala).aRelativa
		val d = new DataEventoMouse(posRelativa, origen(), e.button)
        evento.emitir(d)
	}

    def _obtener_codigo_de_tecla_normalizado(int tecla_qt) {
        val teclas = #{
        	Qt.Key.Key_Left.value -> Tecla.IZQUIERDA,
        	Qt.Key.Key_Right.value -> Tecla::DERECHA,
            Qt.Key.Key_Up.value -> Tecla::ARRIBA,
            Qt.Key.Key_Down.value -> Tecla::ABAJO,
            Qt.Key.Key_Space.value -> Tecla::ESPACIO,
            Qt.Key.Key_Return.value -> Tecla::SELECCION,
            Qt.Key.Key_F1.value -> Tecla::F1,
            Qt.Key.Key_F2.value -> Tecla::F2,
            Qt.Key.Key_F3.value -> Tecla::F3,
            Qt.Key.Key_F4.value -> Tecla::F4,
            Qt.Key.Key_F5.value -> Tecla::F5,
            Qt.Key.Key_F6.value -> Tecla::F6,
            Qt.Key.Key_F7.value -> Tecla::F7,
            Qt.Key.Key_F8.value -> Tecla::F8,
            Qt.Key.Key_F9.value -> Tecla::F9,
            Qt.Key.Key_F10.value -> Tecla::F10,
            Qt.Key.Key_F11.value -> Tecla::F11,
            Qt.Key.Key_F12.value -> Tecla::F12,
            Qt.Key.Key_A.value -> Tecla::a,
            Qt.Key.Key_B.value -> Tecla::b,
            Qt.Key.Key_C.value -> Tecla::c,
            Qt.Key.Key_D.value -> Tecla::d,
            Qt.Key.Key_E.value -> Tecla::e,
            Qt.Key.Key_F.value -> Tecla::f,
            Qt.Key.Key_G.value -> Tecla::g,
            Qt.Key.Key_H.value -> Tecla::h,
            Qt.Key.Key_I.value -> Tecla::i,
            Qt.Key.Key_J.value -> Tecla::j,
            Qt.Key.Key_K.value -> Tecla::k,
            Qt.Key.Key_L.value -> Tecla::l,
            Qt.Key.Key_M.value -> Tecla::m,
            Qt.Key.Key_N.value -> Tecla::n,
            Qt.Key.Key_O.value -> Tecla::o,
            Qt.Key.Key_P.value -> Tecla::p,
            Qt.Key.Key_Q.value -> Tecla::q,
            Qt.Key.Key_R.value -> Tecla::r,
            Qt.Key.Key_S.value -> Tecla::s,
            Qt.Key.Key_T.value -> Tecla::t,
            Qt.Key.Key_U.value -> Tecla::u,
            Qt.Key.Key_V.value -> Tecla::v,
            Qt.Key.Key_W.value -> Tecla::w,
            Qt.Key.Key_X.value -> Tecla::x,
            Qt.Key.Key_Y.value -> Tecla::y,
            Qt.Key.Key_Z.value -> Tecla::z,
            Qt.Key.Key_Plus.value -> Tecla::PLUS,
            Qt.Key.Key_Minus.value -> Tecla::MINUS,
            Qt.Key.Key_Control.value -> Tecla::CTRL,
            Qt.Key.Key_Alt.value -> Tecla::ALT,
            Qt.Key.Key_AltGr.value -> Tecla::ALT, //?
            Qt.Key.Key_Escape.value -> Tecla::ESCAPE
        }

        if (!teclas.containsKey(tecla_qt))
            throw new PilaxException("Tecla QT no soportada por PILAX! Codigo:" + tecla_qt)
        teclas.get(tecla_qt)
    }

    def pantallaCompleta() {
        motor.ventana.showFullScreen
    }

    def pantallaModoVentana() {
        motor.ventana.showNormal
    }

    def estaEnPantallaCompleta() {
        return motor.ventana.isFullScreen
    }

    def alternarPausa() {
        if (pausaHabilitada) {
            pausaHabilitada = false
            actorPausa.eliminar
            eventos.pulsaTecla.desconectarPorId('tecla_en_pausa')
        }
        else {
            pausaHabilitada = true
            actorPausa = new ActorPausa()
            actorPausa.fijo = true
            eventos.pulsaTecla.conectar('tecla_en_pausa', [d| motor.actualizarEventosYActores])
        }
	}
	
    /**
     * Permite cambiar el modo de video.
     * Si está en modo ventana, pasa a pantalla completa y viceversa.
     */
    def alternarPantallaCompleta() {
        if (estaEnPantallaCompleta)
            pantallaModoVentana
        else
            pantallaCompleta
	}
	
}