package org.uqbar.pilax.actores

import java.awt.Color
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.motor.TextoMotor

/**
 * Representa un texto en pantalla.
 *
 * El texto tiene atributos como ``texto``, ``magnitud`` y ``color``, por
 * ejemplo para crear un mensaje de saludo podríamos escribir:
 *
 *   >>> saludo = pilas.actores.Texto("Hola mundo!")
 */
class ActorTexto extends Actor {
	@Property String texto
	@Property int magnitud=20
	@Property boolean vertical = false
	@Property String fuente
	@Property boolean fijo = true
	int _ancho
	int _alto

	new(String texto) {
		this(texto, 0, 0)
	} 

	new(String texto, int x, int y) {
		this(texto, x, y, null)
	} 
	
	/**	Inicializa el actor.
        :param texto: Texto a mostrar.
        :param x: Posición horizontal.
        :param y: Posición vertical.
        :param magnitud: Tamaño del texto.
        :param vertical: Si el texto será vertical u horizontal, como True o False.
        :param fuente: Nombre de la fuente a utilizar.
        :param fijo: Determina si el texto se queda fijo aunque se mueva la camara. Por defecto está fijo.
     */
    new(String texto, int x, int y, String fuente) {
        super(Pilas.instance.mundo.motor.crearTexto(texto, 20, fuente), x, y)
        _definir_area_de_texto(texto, magnitud)
        this.magnitud = magnitud
        this.texto = texto
        this.color = Color.WHITE
        this.centro = centroDeImagen
        this.fijo = fijo
    }

    def getTexto() { imagen.texto }

    def void setTexto(String texto) {
        imagen.texto = texto
        _definir_area_de_texto(texto, magnitud)
    }
    
    override TextoMotor getImagen() {
    	super.imagen as TextoMotor
    }

    def getMagnitud() { imagen.magnitud }

    def void setMagnitud(int magnitud) {
        _magnitud = magnitud
        imagen.magnitud = magnitud
    }

    def getColor() { imagen.color }

    def void setColor(Color color) {
        imagen.color = color
    }

    def _definir_area_de_texto(String texto, int magnitud) {
    	val area = motor.obtenerAreaDeTexto(texto, magnitud, false, null)
       	_ancho = area.key
        _alto = area.value
    }

}