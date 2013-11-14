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
	List<ActorOpcion> opciones_como_actores
	int demora_al_responder
	int opcion_actual
	Control control_menu
	
	new(Map<String, Procedure0> opciones, int x, int y) {
		 this(opciones, x, y, null, Color.gray, Color.white)
	}
	
	new(Map<String, Procedure0> opciones, int x, int y, String fuente, Color color_normal, Color color_resaltado) {
		super("invisible.png", x, y)
		opciones_como_actores = newArrayList
        demora_al_responder = 0
        crear_texto_de_las_opciones(opciones, fuente, color_normal, color_resaltado)
        this.opciones = opciones
        seleccionar_primer_opcion
        opcion_actual = 0
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
        if (!opciones_como_actores.nullOrEmpty)
            opciones_como_actores.get(0).resaltar
	}
	
	def activar() {
        escena.mueveMouse.conectar(id + "mouseMueve", [d| cuando_mueve_el_mouse(d)])
        escena.clickDeMouse.conectar(id + "mouseClick", [d| cuando_hace_click_con_el_mouse(d)])
	}
	
	def desactivar() {
        escena.mueveMouse.desconectarPorId(id + "mouseMueve")
        escena.clickDeMouse.desconectarPorId(id + "mouseClick")
    }
    
    def crear_texto_de_las_opciones(Map<String,Procedure0> opciones, String fuente, Color color_normal, Color color_resaltado) {
    	var indice = 0
        for (opcion : opciones.entrySet) {
            val y = this.y - indice * 50
            val texto = opcion.key
            val funcion = opcion.value
            
            val opcionActor = new ActorOpcion(texto, 0d, y, funcion, fuente, color_normal, color_resaltado)
            opciones_como_actores.add(opcionActor)
            indice = indice + 1
        }
	}
    
    def cuando_mueve_el_mouse(DataEventoMovimiento evento) {
    	var i = 0
        for (opcion : opciones_como_actores) {
            if (opcion.colisionaConPunto(evento.posicion)) {
                if (i != opcion_actual) {
                    _deshabilitar_opcion_actual()
                    opcion_actual = i
                    opciones_como_actores.get(i).resaltar
                }
                return true
            }
            i = i + 1
        }
	}
    
    def cuando_hace_click_con_el_mouse(DataEventoMouse evento) {
        if (cuando_mueve_el_mouse(evento))
            seleccionar_opcion_actual
    }
    
    def mover_cursor(int delta) {
        // Deja como no-seleccionada la opcion actual.
        _deshabilitar_opcion_actual()

        // Se asegura que las opciones esten entre 0 y 'cantidad de opciones'.
        opcion_actual = opcion_actual + delta
        opcion_actual = opcion_actual % opciones_como_actores.size

        // Selecciona la opcion nueva.
        opcionSeleccionada.resaltar
    }
    
    def seleccionar_opcion_actual() {
        opcionSeleccionada.seleccionar
    }
    
    def getOpcionSeleccionada() {
    	opciones_como_actores.get(opcion_actual)
    }
    
    def _deshabilitar_opcion_actual() {
        opcionSeleccionada.resaltar(false)
    }
    
	override actualizar() {
		if (demora_al_responder < 0) {
            if (control_menu.boton) {
                control_menu.limpiar()
                seleccionar_opcion_actual()
                demora_al_responder = DEMORA
			}
            if (control_menu.abajo) {
                mover_cursor(1)
                demora_al_responder = DEMORA
            }
            else if (control_menu.arriba) {
                mover_cursor(-1)
                demora_al_responder = DEMORA
            }
		}
        demora_al_responder = demora_al_responder - 1
	}
	
}