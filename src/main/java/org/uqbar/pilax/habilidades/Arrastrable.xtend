package org.uqbar.pilax.habilidades

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Habilidad
import org.uqbar.pilax.eventos.DataEvento
import org.uqbar.pilax.eventos.DataEventoMouse
import org.uqbar.pilax.fisica.Figura
import org.uqbar.pilax.fisica.Fisica

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class Arrastrable extends Habilidad {
	
	new(Actor receptor) {
		super(receptor)
		//no deberia desregistrar al eliminar la habilidad ?
		escena.clickDeMouse.conectar([d| cuandoIntentaArrastrar(d)])
	}
	
	def cuandoIntentaArrastrar(DataEventoMouse evento) {
		if (evento.botonPrincipal) {
            if (receptor.colisionaConPunto(evento.posicion)) {
                escena.terminaClick.conectar('cuando_termina_de_arrastrar') [d| cuandoTerminaDeArrastrar(d)]
                escena.mueveMouse.conectar('cuando_arrastra') [d| cuandoArrastra(d)]
                comienzaAArrastrar
            }
        }
	}
	
	def comienzaAArrastrar() {
		if (receptor.tieneFisica)
			// HACK CAST!
			fisica.capturar_figura_con_el_mouse(receptor.figura as Figura)
	}
	
	def cuandoTerminaDeArrastrar(DataEvento evento) {
		escena.mueveMouse.desconectarPorId('cuando_arrastra')
        terminaDeArrastrar
        escena.mueveMouse.desconectarPorId('cuando_termina_de_arrastrar')
	}
	
	def terminaDeArrastrar() {
		if (receptor.tieneFisica)
        	fisica.cuando_suelta_el_mouse
	}
	
	def getFisica() {
		// hack
		(escena.fisica as Fisica)
	}
	
	def cuandoArrastra(DataEventoMouse evento) {
		if (receptor.tieneFisica)
            fisica.cuando_mueve_el_mouse(evento.posicion.x.intValue, evento.posicion.y.intValue)
        else {
        	receptor.posicion = receptor.posicion + evento.delta
        }
	}
	
	def getTieneFisica(Actor actor) {
		actor.figura != null
	}
	
}