package org.uqbar.pilax.depurador.modos

import com.trolltech.qt.gui.QPainter
import org.uqbar.pilax.depurador.DepuradorImpl
import org.uqbar.pilax.depurador.ModoDepurador
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.fisica.Fisica
import org.uqbar.pilax.motor.Lienzo
import org.uqbar.pilax.motor.qt.MotorQT

class ModoFisica extends ModoDepurador {
	
	new(DepuradorImpl impl) {
		super(impl, Tecla.F11)
	}
	
	override terminaDibujado(MotorQT motor, QPainter painter, Lienzo lienzo) {
		// CAST hardcoded!
        (Pilas.instance.escenaActual.fisica as Fisica).dibujar_figuras_sobre_lienzo(painter, lienzo, depurador.grosor_de_lineas.intValue)
	}
	
}