package org.uqbar.pilax.engine

import com.trolltech.qt.core.QTimerEvent
import com.trolltech.qt.core.Qt
import com.trolltech.qt.gui.QColor
import com.trolltech.qt.gui.QKeyEvent
import com.trolltech.qt.gui.QMouseEvent
import com.trolltech.qt.gui.QPaintEvent
import com.trolltech.qt.gui.QPainter
import com.trolltech.qt.gui.QWheelEvent
import com.trolltech.qt.gui.QWidget
import java.util.List

import static extension org.uqbar.pilax.engine.PilasExtensions.*
import static extension org.uqbar.pilax.engine.PythonUtils.*

class CanvasNormalWidget extends QWidget {
	QPainter painter
	boolean pausaHabilitada
	int mouseX
	int mouseY
	Motor motor
	List<Actor> listaActores
	FPS fps
	float escala
	//capaz es de QWidget
	int original_width
	int original_height
	DepuradorDeshabilitado depurador
	GestorEscenas gestorEscenas
	ActorPausa actorPausa
	
	new(Motor motor, List<Actor> lista_actores, int ancho, int alto, GestorEscenas gestor_escenas, boolean permitir_depuracion, double rendimiento) {
		super(null as QWidget)
//        this.painter = new QPainter()
        setMouseTracking = true
        this.pausaHabilitada = false
        mouseX = 0
        mouseY = 0
        this.motor = motor
        listaActores = lista_actores
        fps = new FPS(rendimiento, true)

//        if (permitir_depuracion) {
//            depurador = new Depurador(motor.obtenerLienzo(), self.fps)
//        }
//        else {
            depurador = new DepuradorDeshabilitado
//        }

        self.original_width = ancho
        self.original_height = alto
        self.escala = 1
        self.startTimer(1000/100)

        gestorEscenas = gestor_escenas
    }

    def resize_to(int w, int h) {
        val escala_x = w / Float.valueOf(self.original_width)
        val escala_y = h / Float.valueOf(self.original_height)
        val escala = Math.min(escala_x, escala_y)

        val final_w = (self.original_width * escala).intValue
        val final_h = (self.original_height * escala).intValue
        self.escala = escala

        val x = w - final_w
        val y = h - final_h

        self.setGeometry(x / 2, y / 2, final_w, final_h)
	}
	
	override protected paintEvent(QPaintEvent event) {
		//PILAX ( tuve que mover esto para que genere un nuevo painter cada
		// vez, sino me fallaba. En pilas no es así! :(
//		if (this.painter == null)
			this.painter = new QPainter()
		painter.begin(this)

        painter.scale(escala, escala)

        painter.setRenderHint(QPainter.RenderHint.HighQualityAntialiasing, true)
        painter.setRenderHint(QPainter.RenderHint.SmoothPixmapTransform, true)
        painter.setRenderHint(QPainter.RenderHint.Antialiasing, true)

        painter.fillRect(0, 0, original_width, original_height, new QColor(128, 128, 128))
        depurador.comienza_dibujado(motor, painter)

//        val actores_a_eliminar = newArrayList

        if (gestorEscenas.escenaActual != null) {
            val actores_de_la_escena = self.gestorEscenas.escenaActual.actores
            for (actor : actores_de_la_escena) {
//             if actor._vivo:
                try {
                    if (!actor.estaFueraDeLaPantalla())
                        actor.dibujar(self.painter)
                }
                catch (Exception e) {
                    e.printStackTrace
                    actor.eliminar()
                }

                self.depurador.dibuja_al_actor(self.motor, self.painter, actor)
//              else:
//                  actores_a_eliminar.append(actor)
//
//              for x in actores_a_eliminar:
//                  actores_de_la_escena.remove(x)
			}
		}
        self.depurador.termina_dibujado(self.motor, self.painter)
        self.painter.end()
	}
	
	override protected timerEvent(QTimerEvent event) {
        try {
            self.realizarActualizacionLogica
	    }
        catch(Exception e) {
        	e.printStackTrace
        }
        self.update()
    }

    def realizarActualizacionLogica() {
        for (x : range(self.fps.actualizar())){
            if (!self.pausaHabilitada) {
                self.actualizarEventosYActores
                self.actualizarEscena
            }
        }
    }

    def protected actualizarEscena() {
        self.gestorEscenas.actualizar
	}

    def actualizarEventosYActores() {
        Pilas.instance.escenaActual.actualizar.emitir(new DataEvento)

        try {
        	gestorEscenas.escenaActual.actores.forEach[preActualizar; actualizar]
        }
        catch (Exception e) {
            e.printStackTrace
        }
	}
	
	override protected mouseMoveEvent(QMouseEvent e) {
        val escala = self.escala
        val posRelativa = Utils.convertirDePosicionFisicaRelativa(e.pos().x() / escala, e.pos().y() / escala)
        var x = posRelativa.key
        var y = posRelativa.value

//		val bordes = Utils.obtenerBordes()
//		val izquierda = bordes.izquierda
//		val derecha = bordes.derecha
//		val arriba = bordes.arriba
//		val abajo = bordes.abajo
//      x = max(min(derecha, x), izquierda)
//      y = max(min(arriba, y), abajo)

        x = x + Pilas.instance.mundo.motor.camaraX
        y = y + Pilas.instance.mundo.motor.camaraY

        val dx = x - self.mouseX
        val dy = y - self.mouseY

        self.gestorEscenas.escenaActual.mueveMouse.emitir(new DataEventoMouse(x, y, dx, dy, null))

        self.mouseX = x.intValue
        self.mouseY = y.intValue
        self.depurador.cuando_mueve_el_mouse(x.intValue, y.intValue)
	}
	
	override protected keyPressEvent(QKeyEvent event) {
        val codigo_de_tecla = self._obtener_codigo_de_tecla_normalizado(event.key())

        // Se mantiene este lanzador de eventos por la clase Control
        if (event.key() == Qt.Key.Key_Escape)
            eventos.pulsaTeclaEscape.emitir(new DataEvento)
        if (event.key() == Qt.Key.Key_P && event.modifiers() == Qt.KeyboardModifier.AltModifier)
            self.alternar_pausa()
        if (event.key() == Qt.Key.Key_F && event.modifiers() == Qt.KeyboardModifier.AltModifier)
            self.alternar_pantalla_completa()

        eventos.pulsaTecla.emitir(new DataEventoTeclado(codigo_de_tecla, event.isAutoRepeat(), event.text()))
        self.depurador.cuando_pulsa_tecla(codigo_de_tecla, event.text())
    }
    
	override protected keyReleaseEvent(QKeyEvent event) {
        val codigo_de_tecla = self._obtener_codigo_de_tecla_normalizado(event.key())
        // Se mantiene este lanzador de eventos por la clase Control
        eventos.sueltaTecla.emitir(new DataEventoTeclado(codigo_de_tecla, event.isAutoRepeat(), event.text()))
    }
    
	override protected wheelEvent(QWheelEvent e) {
        self.gestorEscenas.escenaActual.mueveRueda.emitir(new DataEventoRuedaMouse(e.delta() / 120))
	}
	
	override protected mousePressEvent(QMouseEvent e) {
		triggerearEventoDeMouseClick(e, gestorEscenas.escenaActual.clickDeMouse)
	}
	
	override protected mouseReleaseEvent(QMouseEvent e) {
		triggerearEventoDeMouseClick(e, gestorEscenas.escenaActual.terminaClick)        
    }
    
    def protected triggerearEventoDeMouseClick(QMouseEvent e, Evento evento) {
		val escala = self.escala
        val posRelativa = Utils.convertirDePosicionFisicaRelativa(e.pos.x / escala, e.pos.y / escala).relativaALaCamara
        var x = posRelativa.key 
        var y = posRelativa.value

        evento.emitir(new DataEventoMouse(x, y, 0f, 0f, e.button()))
	}

    def _obtener_codigo_de_tecla_normalizado(int tecla_qt) {
        val teclas = #{
        	Qt.Key.Key_Left.value -> Simbolos.IZQUIERDA,
        	Qt.Key.Key_Right.value -> Simbolos::DERECHA,
            Qt.Key.Key_Up.value -> Simbolos::ARRIBA,
            Qt.Key.Key_Down.value -> Simbolos::ABAJO,
            Qt.Key.Key_Space.value -> Simbolos::ESPACIO,
            Qt.Key.Key_Return.value -> Simbolos::SELECCION,
            Qt.Key.Key_F1.value -> Simbolos::F1,
            Qt.Key.Key_F2.value -> Simbolos::F2,
            Qt.Key.Key_F3.value -> Simbolos::F3,
            Qt.Key.Key_F4.value -> Simbolos::F4,
            Qt.Key.Key_F5.value -> Simbolos::F5,
            Qt.Key.Key_F6.value -> Simbolos::F6,
            Qt.Key.Key_F7.value -> Simbolos::F7,
            Qt.Key.Key_F8.value -> Simbolos::F8,
            Qt.Key.Key_F9.value -> Simbolos::F9,
            Qt.Key.Key_F10.value -> Simbolos::F10,
            Qt.Key.Key_F11.value -> Simbolos::F11,
            Qt.Key.Key_F12.value -> Simbolos::F12,
            Qt.Key.Key_A.value -> Simbolos::a,
            Qt.Key.Key_B.value -> Simbolos::b,
            Qt.Key.Key_C.value -> Simbolos::c,
            Qt.Key.Key_D.value -> Simbolos::d,
            Qt.Key.Key_E.value -> Simbolos::e,
            Qt.Key.Key_F.value -> Simbolos::f,
            Qt.Key.Key_G.value -> Simbolos::g,
            Qt.Key.Key_H.value -> Simbolos::h,
            Qt.Key.Key_I.value -> Simbolos::i,
            Qt.Key.Key_J.value -> Simbolos::j,
            Qt.Key.Key_K.value -> Simbolos::k,
            Qt.Key.Key_L.value -> Simbolos::l,
            Qt.Key.Key_M.value -> Simbolos::m,
            Qt.Key.Key_N.value -> Simbolos::n,
            Qt.Key.Key_O.value -> Simbolos::o,
            Qt.Key.Key_P.value -> Simbolos::p,
            Qt.Key.Key_Q.value -> Simbolos::q,
            Qt.Key.Key_R.value -> Simbolos::r,
            Qt.Key.Key_S.value -> Simbolos::s,
            Qt.Key.Key_T.value -> Simbolos::t,
            Qt.Key.Key_U.value -> Simbolos::u,
            Qt.Key.Key_V.value -> Simbolos::v,
            Qt.Key.Key_W.value -> Simbolos::w,
            Qt.Key.Key_X.value -> Simbolos::x,
            Qt.Key.Key_Y.value -> Simbolos::y,
            Qt.Key.Key_Z.value -> Simbolos::z
        }

        if (teclas.containsKey(tecla_qt))
            return teclas.get(tecla_qt)
        else
            return tecla_qt
    }

    def pantallaCompleta() {
        self.motor.ventana.showFullScreen
    }

    def pantalla_modo_ventana() {
        self.motor.ventana.showNormal
    }

    def esta_en_pantalla_completa() {
        return self.motor.ventana.isFullScreen
    }

    def alternar_pausa() {
        if (self.pausaHabilitada) {
            self.pausaHabilitada = false
            self.actorPausa.eliminar
            eventos.pulsaTecla.desconectarPorId('tecla_en_pausa')
        }
        else {
            self.pausaHabilitada = true
            self.actorPausa = new ActorPausa()
            self.actorPausa.fijo = true
            //No parece usarse el id en pilas
            /*self.idEvento = */eventos.pulsaTecla.conectar('tecla_en_pausa', [DataEventoTeclado data | avanzar_un_solo_cuadro_de_animacion(data)])
        }
	}
	
    def avanzar_un_solo_cuadro_de_animacion(DataEventoTeclado data) {
        self.actualizarEventosYActores
    }

    /**Permite cambiar el modo de video.
        Si está en modo ventana, pasa a pantalla completa y viceversa.
        */
    def alternar_pantalla_completa() {
        if (self.esta_en_pantalla_completa())
            self.pantalla_modo_ventana()
        else
            self.pantallaCompleta
	}
	
}