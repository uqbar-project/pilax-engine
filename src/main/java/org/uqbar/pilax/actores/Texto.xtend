package org.uqbar.pilax.actores

import com.trolltech.qt.gui.QFont
import java.awt.Color
import org.uqbar.pilax.engine.Actor

import static extension org.uqbar.pilax.engine.PilasExtensions.*
import static extension org.uqbar.pilax.engine.PythonUtils.*
import org.uqbar.pilax.engine.Pilas

/**
 *     """Representa un texto en pantalla.

    El texto tiene atributos como ``texto``, ``magnitud`` y ``color``, por
    ejemplo para crear un mensaje de saludo podríamos escribir:

        >>> saludo = pilas.actores.Texto("Hola mundo!")
    """
 */
class Texto extends Actor {
	@Property String texto
	@Property int magnitud=20
	@Property boolean vertical = false
	@Property QFont fuente
	@Property boolean fijo = true
	int _ancho
	int _alto

    new(String texto, int x, int y) {
        /**Inicializa el actor.

        :param texto: Texto a mostrar.
        :param x: Posición horizontal.
        :param y: Posición vertical.
        :param magnitud: Tamaño del texto.
        :param vertical: Si el texto será vertical u horizontal, como True o False.
        :param fuente: Nombre de la fuente a utilizar.
        :param fijo: Determina si el texto se queda fijo aunque se mueva la camara. Por defecto está fijo.
        */
        super(Pilas.instance.mundo.motor.obtenerTexto(texto, 20, null), x, y)
        _definir_area_de_texto(texto, magnitud)
        self.magnitud = magnitud
        self.texto = texto
        self.color = Color.WHITE
        self.centro = centroDeImagen
        self.fijo = fijo
    }

    def getTexto() {
        self.imagen.texto
    }

    def void setTexto(String texto) {
        imagen.texto = texto
        _definir_area_de_texto(texto, self.magnitud)
    }
    
    override org.uqbar.pilax.engine.Texto getImagen() {
    	super.imagen as org.uqbar.pilax.engine.Texto
    }

    def getMagnitud() {
        self.imagen.magnitud
    }

    def void setMagnitud(int magnitud) {
        _magnitud = magnitud
        imagen.magnitud = magnitud
    }

    def getColor() {
        imagen.color
    }

    def void setColor(Color color) {
        imagen.color = color
    }

    def _definir_area_de_texto(String texto, int magnitud) {
    	val area = pilas.mundo.motor.obtenerAreaDeTexto(texto, magnitud, false, null)
        self._ancho = area.key
        self._alto = area.value
    }
	
}