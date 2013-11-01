package org.uqbar.pilax.engine

import static extension org.uqbar.pilax.engine.PilasExtensions.*
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
        this.painter = new QPainter()
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
		painter.begin(painter.device)
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
            self._realizarActualizacionLogica
	    }
        catch(Exception e) {
        	e.printStackTrace
        }
        self.update()
    }

    def _realizarActualizacionLogica() {
        for (x : range(self.fps.actualizar())){
            if (!self.pausaHabilitada) {
                self.actualizar_eventos_y_actores
                self.actualizarEscena
            }
        }
    }

    def protected actualizarEscena() {
        self.gestorEscenas.actualizar
	}

    def actualizar_eventos_y_actores() {
        Pilas.instance.escenaActual.actualizar.emitir()

        try {
        	self.gestorEscenas.escenaActual.actores.forEach[preActualizar; actualizar]
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

        self.gestorEscenas.escenaActual.mueveMouse.emitir(x, y, dx, dy)

        self.mouseX = x.intValue
        self.mouseY = y.intValue
        self.depurador.cuando_mueve_el_mouse(x.intValue, y.intValue)
	}
	
	override protected keyPressEvent(QKeyEvent event) {
        val codigo_de_tecla = self._obtener_codigo_de_tecla_normalizado(event.key())

        // Se mantiene este lanzador de eventos por la clase Control
        if (event.key() == Qt.Key.Key_Escape)
            eventos.pulsaTeclaEscape.emitir()
        if (event.key() == Qt.Key.Key_P && event.modifiers() == Qt.KeyboardModifier.AltModifier)
            self.alternar_pausa()
        if (event.key() == Qt.Key.Key_F && event.modifiers() == Qt.KeyboardModifier.AltModifier)
            self.alternar_pantalla_completa()

        eventos.pulsaTecla.emitir(codigo_de_tecla, event.isAutoRepeat(), event.text())
        self.depurador.cuando_pulsa_tecla(codigo_de_tecla, event.text())
    }
    
	override protected keyReleaseEvent(QKeyEvent event) {
        val codigo_de_tecla = self._obtener_codigo_de_tecla_normalizado(event.key())
        // Se mantiene este lanzador de eventos por la clase Control
        eventos.sueltaTecla.emitir(codigo_de_tecla, event.isAutoRepeat(), event.text())
    }
    
	override protected wheelEvent(QWheelEvent e) {
        self.gestorEscenas.escenaActual.mueveRueda.emitir(e.delta() / 120)
	}
	
	override protected mousePressEvent(QMouseEvent e) {
        val escala = self.escala
        val posRelativa = Utils.convertirDePosicionFisicaRelativa(e.pos().x()/escala, e.pos().y()/escala)
        var x = posRelativa.key
        var y = posRelativa.value
        val boton_pulsado = e.button()

        x = x + Pilas.instance.mundo.motor.camaraX
        y = y + Pilas.instance.mundo.motor.camaraY

        self.gestorEscenas.escenaActual.clickDeMouse.emitir(x, y, 0, 0, boton_pulsado)
	}
	
	override protected mouseReleaseEvent(QMouseEvent e) {
		// codigo repetido !!
        val escala = self.escala
        val posRelativa = Utils.convertirDePosicionFisicaRelativa(e.pos().x()/escala, e.pos().y()/escala)
        var x = posRelativa.key
        var y = posRelativa.value
        val boton_pulsado = e.button()

        x = x + Pilas.instance.mundo.motor.camaraX
        y = y + Pilas.instance.mundo.motor.camaraY

        self.gestorEscenas.escenaActual.terminaClick.emitir(x, y, 0, 0, boton_pulsado)
    }

    def _obtener_codigo_de_tecla_normalizado(int tecla_qt) {
        val teclas = #{
        	Qt.Key.Key_Left -> Simbolos.IZQUIERDA,
        	Qt.Key.Key_Right -> Simbolos::DERECHA,
            Qt.Key.Key_Up -> Simbolos::ARRIBA,
            Qt.Key.Key_Down -> Simbolos::ABAJO,
            Qt.Key.Key_Space -> Simbolos::ESPACIO,
            Qt.Key.Key_Return -> Simbolos::SELECCION,
            Qt.Key.Key_F1 -> Simbolos::F1,
            Qt.Key.Key_F2 -> Simbolos::F2,
            Qt.Key.Key_F3 -> Simbolos::F3,
            Qt.Key.Key_F4 -> Simbolos::F4,
            Qt.Key.Key_F5 -> Simbolos::F5,
            Qt.Key.Key_F6 -> Simbolos::F6,
            Qt.Key.Key_F7 -> Simbolos::F7,
            Qt.Key.Key_F8 -> Simbolos::F8,
            Qt.Key.Key_F9 -> Simbolos::F9,
            Qt.Key.Key_F10 -> Simbolos::F10,
            Qt.Key.Key_F11 -> Simbolos::F11,
            Qt.Key.Key_F12 -> Simbolos::F12,
            Qt.Key.Key_A -> Simbolos::a,
            Qt.Key.Key_B -> Simbolos::b,
            Qt.Key.Key_C -> Simbolos::c,
            Qt.Key.Key_D -> Simbolos::d,
            Qt.Key.Key_E -> Simbolos::e,
            Qt.Key.Key_F -> Simbolos::f,
            Qt.Key.Key_G -> Simbolos::g,
            Qt.Key.Key_H -> Simbolos::h,
            Qt.Key.Key_I -> Simbolos::i,
            Qt.Key.Key_J -> Simbolos::j,
            Qt.Key.Key_K -> Simbolos::k,
            Qt.Key.Key_L -> Simbolos::l,
            Qt.Key.Key_M -> Simbolos::m,
            Qt.Key.Key_N -> Simbolos::n,
            Qt.Key.Key_O -> Simbolos::o,
            Qt.Key.Key_P -> Simbolos::p,
            Qt.Key.Key_Q -> Simbolos::q,
            Qt.Key.Key_R -> Simbolos::r,
            Qt.Key.Key_S -> Simbolos::s,
            Qt.Key.Key_T -> Simbolos::t,
            Qt.Key.Key_U -> Simbolos::u,
            Qt.Key.Key_V -> Simbolos::v,
            Qt.Key.Key_W -> Simbolos::w,
            Qt.Key.Key_X -> Simbolos::x,
            Qt.Key.Key_Y -> Simbolos::y,
            Qt.Key.Key_Z -> Simbolos::z
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
            /*self.idEvento = */eventos.pulsaTecla.conectar('tecla_en_pausa', [Evento e | avanzar_un_solo_cuadro_de_animacion(e)])
        }
	}
	
    def avanzar_un_solo_cuadro_de_animacion(Evento evento) {
        self.actualizar_eventos_y_actores
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