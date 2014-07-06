package org.uqbar.pilax.motor.java2d

import org.uqbar.pilax.geom.Area
import org.uqbar.pilax.motor.ActorMotor
import org.uqbar.pilax.motor.ImagenMotor
import org.uqbar.pilax.motor.Lienzo
import org.uqbar.pilax.motor.Motor
import org.uqbar.pilax.motor.Superficie
import org.uqbar.pilax.motor.TextoMotor

import static extension org.uqbar.pilax.utils.PilasExtensions.*

/**
 * 
 */
abstract class AbstractMotor implements Motor {
	protected double anchoOriginal
	protected double altoOriginal
	@Property Pair<Double, Double> centroDeLaCamara = origen
	
	override crearActor(ImagenMotor imagen, double x, double y) {
		new ActorMotor(imagen, x, y)
	}
	
	/** Centro de la ventana para situar el punto (0, 0)*/
	override getCentroFisico() {
        area / 2
	}
	
	override getArea() {
		(anchoOriginal -> altoOriginal)
	}
	
	override cargarImagen(String path) {
		new ImagenMotor(path)
	}
	
	override crearTexto(String texto, int magnitud, String fuente) {
       new TextoMotor(texto, magnitud, this, false, fuente)
    }
    
    override crearLienzo() {
		new Lienzo
	}
    
    override crearSuperficie(int ancho, int alto) {
    	new Superficie(ancho, alto)
    }
    
    override Pair<Integer, Integer> obtenerAreaDeTexto(String texto) {
		obtenerAreaDeTexto(texto, 10, false, null)
	}
	
	override getBordes() {
		val anchoBorde = area.ancho / 2
		val altoBorde = area.alto / 2
    	return new Area(-anchoBorde, anchoBorde, altoBorde, -altoBorde)
	}
}