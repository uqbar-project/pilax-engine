package org.uqbar.pilax.depurador.modos

import com.trolltech.qt.gui.QPainter
import java.awt.Color
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.depurador.DepuradorImpl
import org.uqbar.pilax.depurador.ModoDepurador
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.motor.Lienzo

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import org.uqbar.pilax.utils.Utils
import java.util.Iterator
import org.uqbar.pilax.motor.qt.MotorQT

class ModoCamara extends ModoDepurador {
	Pair<Double, Double> posicionOriginal
	Iterator<Actor> actores
	Actor actorEnFoco
	
	new(DepuradorImpl impl) {
		super(impl, Tecla.F3)
		posicionOriginal = camara.posicion.copy
		actores = Pilas.instance.escenaActual.actores.iterator
		escena.pulsaTecla.conectar(id) [d|
			switch (d.tecla) {
				case Tecla.DERECHA: proximoActor
//				case Tecla.IZQUIERDA: 
			}
		]
	}
	
	def id() {
		System.identityHashCode(this).toString
	}
	
	def escena() {
		Pilas.instance.escenaActual
	}
	
	def tiempoTransicion(double a, double b) {
		Math.abs(a - b) / 100
	}
	
	override dibujaAlActor(MotorQT motor, QPainter painter, Lienzo lienzo, Actor actor) {
//		if (control.derecha) {
//			proximoActor
//		}
		if (actorEnFoco != null) {
//			lienzo.texto(painter, "uid=" + actorEnFoco.id, -200, 100, Color.white)
			// todo, hacer intermitente
			lienzo.rectangulo(painter, actorEnFoco.posicionRelativaACamara.x, actorEnFoco.posicionRelativaACamara.y, actorEnFoco.ancho, actorEnFoco.alto, Color.red, 2)
			lienzo.texto(painter, "id=" + actorEnFoco.id, actorEnFoco.posicionRelativaACamara.x.intValue - (actorEnFoco.ancho / 2).intValue, actorEnFoco.posicionRelativaACamara.y.intValue - actorEnFoco.radioDeColision, Color.white)
		}
	}
	
	def proximoActor() {
		if (!actores.hasNext)
			actores = Pilas.instance.escenaActual.actores.copy.iterator
		
		actorEnFoco = actores.next
		
		// mover camara
		val pos = actorEnFoco.posicion
		Utils.interpolar(camara, "x", #[pos.x], tiempoTransicion(camara.x, pos.x))
		Utils.interpolar(camara, "y", #[pos.y], tiempoTransicion(camara.y, pos.y))
		
//		var i = 0
//		if (actorEnFoco != null && actorEnFoco.vivo) {
//			i = Pilas.instance.escenaActual.actores.indexOf(this.actorEnFoco)
//			i = i + 1 
//			if (i >= Pilas.instance.escenaActual.actores.size)
//				i = 0
//		}
//		actorEnFoco = Pilas.instance.escenaActual.actores.get(i)
	}
	
	override saleDelModo() {
		escena.pulsaTecla.desconectarPorId(id)
		camara.posicion = posicionOriginal
	}

	def getControl() {
		Pilas.instance.escenaActual.control
	}
	
	def getCamara() {
		Pilas.instance.escenaActual.camara
	}
	
}