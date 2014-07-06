package org.uqbar.pilax.motor

import java.awt.Color
import java.util.List
import org.uqbar.pilax.utils.Utils

import static extension org.uqbar.pilax.utils.PilasExtensions.*

/**
 * @author jfernandes
 */
class Lienzo extends ImagenMotor {
    
    def texto(PilasPainter painter, String cadena) {
    	texto(painter, cadena, 0, 0, 10, null, Color.BLACK)
    }
    
    def texto(PilasPainter painter, String cadena, int x, int y, Color color) {
    	texto(painter, cadena, x, y, 10, null, color)
    }
    
    /** Imprime un texto respespetando el desplazamiento de la camara. */
    def texto(PilasPainter painter, String cadena, int x, int y, int magnitud, String fuente, Color color) {
        texto_absoluto(painter, cadena, x, y, magnitud, fuente, color)
    }

	def texto_absoluto(PilasPainter painter, String cadena, double x, double y, Color color) {
		texto_absoluto(painter, cadena, x, y, 10, null, color)
	}

    /** Imprime un texto sin respetar al camara.*/
    def texto_absoluto(PilasPainter painter, String cadena, double x, double y, int magnitud, String fuente, Color color) {
        painter.drawAbsoluteText(cadena, x, y, magnitud, fuente, color)
	}
	
    def pintar(PilasPainter painter, Color color) {
        painter.fillRect(origen, mundo.area, color)
    }

    def linea(PilasPainter painter, double x0, double y0, double x1, double y1, Color color, int grosor) {
        painter.setPen(color, grosor)
        painter.drawLine(Utils.aAbsoluta(x0, y0), Utils.aAbsoluta(x1, y1))
    }

	def poligono(PilasPainter painter, List<Pair<Double,Double>> puntos) {
		poligono(painter, puntos, Color.black, 1, false)
	}

    def poligono(PilasPainter painter, List<Pair<Double,Double>> puntos, Color color, int grosor, boolean cerrado) {
        var first = puntos.get(0)
        if (cerrado)
            puntos.add(first)

        for (p : puntos.subList(1)) {
            val nuevo_x = p.x
            val nuevo_y = p.y
            linea(painter, first.x, first.y, nuevo_x, nuevo_y, color, grosor)
            first = p
        }
    }

    def cruz(PilasPainter painter, int x, int y, Color color, int grosor) {
        val t = 3
        linea(painter, x - t, y - t, x + t, y + t, color, grosor)
        linea(painter, x + t, y - t, x - t, y + t, color, grosor)
    }

    def circulo(PilasPainter painter, double x, double y, double radio, Color color /* =colores.negro*/, int grosor) {
        val pos = Utils.aAbsoluta(x, y)
        painter.setPen(color, grosor)
        painter.drawEllipse(pos.x - radio, pos.y - radio, radio * 2, radio * 2)
    }

	def rectangulo(PilasPainter painter, int x, int y, int ancho, int alto) {
		rectangulo(painter, x, y, ancho, alto, Color.black, 1, false)
	}

	def rectangulo(PilasPainter painter, double x, double y, double ancho, double alto, Color color, int grosor) {
		rectangulo(painter, x, y, ancho, alto, color, grosor, false)
	}

    def rectangulo(PilasPainter painter, double x, double y, double ancho, double alto, Color color, int grosor, boolean fill) {
        painter.setPen(color, grosor)
        if (fill)
        	painter.fillRect(Utils.aAbsoluta(x, y), ancho, alto, color)
        else 
        	painter.drawRect(Utils.aAbsoluta(x, y), ancho, alto)
    }
	
}