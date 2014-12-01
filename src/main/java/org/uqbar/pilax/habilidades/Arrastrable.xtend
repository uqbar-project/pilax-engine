package org.uqbar.pilax.habilidades

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Habilidad
import org.uqbar.pilax.eventos.DataEvento
import org.uqbar.pilax.eventos.DataEventoMouse
import org.uqbar.pilax.eventos.HandlerEvento
import org.uqbar.pilax.fisica.Figura
import org.uqbar.pilax.fisica.Fisica

import static extension org.uqbar.pilax.utils.PilasExtensions.*

/**
 * @author jfernandes
 */
class Arrastrable extends Habilidad {
	HandlerEvento<DataEventoMouse> moveHandler = [d| cuandoArrastra(d)]
	HandlerEvento<DataEventoMouse> dragEndHandler = [d| cuandoTerminaDeArrastrar(d)]
	
	new(Actor receptor) {
		super(receptor)
		//no deberia desregistrar al eliminar la habilidad ?
		escena.clickDeMouse.conectar([d| cuandoIntentaArrastrar(d)])
	}
	
	def cuandoIntentaArrastrar(DataEventoMouse evento) {
		if (evento.botonPrincipal) {
            if (receptor.colisionaConPunto(evento.posicion)) {
                escena.terminaClick.conectar(dragEndHandler) 
                escena.mueveMouse.conectar(moveHandler)
                comienzaAArrastrar
            }
        }
	}
	
	def comienzaAArrastrar() {
		if (receptor.tieneFisica)
			// HACK CAST!
			fisica.capturarFiguraConElMouse(receptor.figura as Figura)
	}
	
	def cuandoTerminaDeArrastrar(DataEvento evento) {
		escena.mueveMouse.desconectar(moveHandler)
        terminaDeArrastrar
        escena.mueveMouse.desconectar(dragEndHandler)
	}
	
	def terminaDeArrastrar() {
		if (receptor.tieneFisica)
        	fisica.cuandoSueltaElMouse
	}
	
	def getFisica() {
		// hack
		(escena.fisica as Fisica)
	}
	
	def cuandoArrastra(DataEventoMouse evento) {
		if (receptor.tieneFisica)
            fisica.cuandoMueveElMouse(evento.posicion.x.intValue, evento.posicion.y.intValue)
        else
        	receptor.posicion = receptor.posicion + evento.delta
	}
	
	def getTieneFisica(Actor actor) {
		actor.figura != null
	}
	
}