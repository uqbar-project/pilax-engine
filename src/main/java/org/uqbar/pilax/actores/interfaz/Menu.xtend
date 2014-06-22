package org.uqbar.pilax.actores.interfaz

import java.awt.Color
import java.util.List
import java.util.Map
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Control
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.eventos.DataEventoMouse
import org.uqbar.pilax.eventos.DataEventoMovimiento

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import org.eclipse.xtext.xbase.lib.Procedures.Procedure0

class Menu extends Actor {
	static val DEMORA = 14
	Map<String,Procedure0> opciones	
	List<ActorOpcion> opcionesComoActores
	int demoraAlResponder
	int opcionActual
	Control control_menu
	
	new(Map<String, Procedure0> opciones, int x, int y) {
		 this(opciones, x, y, null, Color.gray, Color.white)
	}
	
	new(Map<String, Procedure0> opciones, int x, int y, String fuente, Color color_normal, Color color_resaltado) {
		super("invisible.png", x, y)
		opcionesComoActores = newArrayList
        demoraAlResponder = 0
        crearTextoDeLasOpciones(opciones, fuente, color_normal, color_resaltado)
        this.opciones = opciones
        seleccionar_primer_opcion
        opcionActual = 0
        // contador para evitar la repeticion de teclas
        activar

        // Mapeamos unas teclas para mover el menu
//        val teclas = #{Tecla.IZQUIERDA -> 'izquierda',
//                              Tecla.DERECHA -> 'derecha',
//                              Tecla.ARRIBA -> 'arriba',
//                              Tecla.ABAJO -> 'abajo',
//                              Tecla.SELECCION -> 'boton'
//                      }

        // Creamos un control personalizado
//        control_menu = new Control(pilas.escenaActual, teclas)
		control_menu = new Control(pilas.escenaActual)
	}
	
	def seleccionar_primer_opcion() {
        if (!opcionesComoActores.nullOrEmpty)
            opcionesComoActores.get(0).resaltar
	}
	
	def activar() {
        escena.mueveMouse.conectar(id + "mouseMueve", [d| cuandoMueveElMouse(d)])
        escena.clickDeMouse.conectar(id + "mouseClick", [d| cuandoHaceClickConElMouse(d)])
	}
	
	def desactivar() {
        escena.mueveMouse.desconectarPorId(id + "mouseMueve")
        escena.clickDeMouse.desconectarPorId(id + "mouseClick")
    }
    
    def crearTextoDeLasOpciones(Map<String,Procedure0> opciones, String fuente, Color color_normal, Color color_resaltado) {
    	var indice = 0
        for (opcion : opciones.entrySet) {
            val y = this.y - indice * 50
            opcionesComoActores += new ActorOpcion(opcion.key, 0d, y, opcion.value, fuente, color_normal, color_resaltado) 
            indice = indice + 1
        }
	}
    
    def cuandoMueveElMouse(DataEventoMovimiento evento) {
    	var i = 0
        for (opcion : opcionesComoActores) {
            if (opcion.colisionaConPunto(evento.posicion)) {
                if (i != opcionActual) {
                    deshabilitarOpcionActual
                    opcionActual = i
                    opcionesComoActores.get(i).resaltar
                }
                return true
            }
            i = i + 1
        }
	}
    
    def cuandoHaceClickConElMouse(DataEventoMouse evento) {
        if (cuandoMueveElMouse(evento))
            seleccionarOpcionActual
    }
    
    def moverCursor(int delta) {
        deshabilitarOpcionActual
        opcionActual = opcionActual + delta
        opcionSeleccionada.resaltar
    }
    
    def seleccionarOpcionActual() {
        opcionSeleccionada.seleccionar
    }
    
    def getOpcionSeleccionada() {
    	opcionesComoActores.get(opcionActual)
    }
    
    def deshabilitarOpcionActual() {
        opcionSeleccionada.resaltar(false)
    }
    
	override actualizar() {
		if (demoraAlResponder < 0) {
            if (control_menu.boton) {
                control_menu.limpiar()
                seleccionarOpcionActual()
                demoraAlResponder = DEMORA
			}
            if (control_menu.abajo && opcionActual < opcionesComoActores.size - 1) {
                moverCursor(1)
                demoraAlResponder = DEMORA
            }
            else if (control_menu.arriba && opcionActual > 0) {
                moverCursor(-1)
                demoraAlResponder = DEMORA
            }
		}
        demoraAlResponder = demoraAlResponder - 1
	}
	
}