package org.uqbar.pilax.motor

import com.trolltech.qt.gui.QFont
import com.trolltech.qt.gui.QPainter
import com.trolltech.qt.gui.QPen
import java.awt.Color
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.utils.Utils

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.motor.qt.QtExtensions.*
import org.uqbar.pilax.motor.qt.Motor
import java.util.List

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import com.trolltech.qt.gui.QBrush

class Lienzo extends ImagenMotor {
    
    def texto(QPainter painter, String cadena) {
    	texto(painter, cadena, 0, 0, 10, null, Color.BLACK)
    }
    
    def texto(QPainter painter, String cadena, int x, int y, Color color) {
    	texto(painter, cadena, x, y, 10, null, color)
    }
    
    /** Imprime un texto respespetando el desplazamiento de la camara. */
    def texto(QPainter painter, String cadena, int x, int y, int magnitud, String fuente, Color color) {
        texto_absoluto(painter, cadena, x, y, magnitud, fuente, color)
    }

	def texto_absoluto(QPainter painter, String cadena, double x, double y, Color color) {
		texto_absoluto(painter, cadena, x, y, 10, null, color)
	}

    /** Imprime un texto sin respetar al camara.*/
    def texto_absoluto(QPainter painter, String cadena, double x, double y, int magnitud, String fuente, Color color) {
        painter.pen = color.asQColor
		val nombre_de_fuente = if (fuente != null) TextoMotor.cargar_fuente_desde_cache(fuente) else painter.font.family
        painter.font = new QFont(nombre_de_fuente, magnitud)
        
        painter.drawText(Utils.aAbsoluta(x, y), cadena)
	}
	
    def pintar(QPainter painter, Color color) {
        painter.fillRect(origen, mundo.area, color)
    }

    def linea(QPainter painter, double x0, double y0, double x1, double y1, Color color, int grosor) {
        painter.pen = color.createPen(grosor)
        painter.drawLine(Utils.aAbsoluta(x0, y0), Utils.aAbsoluta(x1, y1))
    }

	def poligono(QPainter painter, List<Pair<Double,Double>> puntos) {
		poligono(painter, puntos, Color.black, 1, false)
	}

    def poligono(QPainter painter, List<Pair<Double,Double>> puntos, Color color, int grosor, boolean cerrado) {
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

    def cruz(QPainter painter, int x, int y, Color color, int grosor) {
        val t = 3
        linea(painter, x - t, y - t, x + t, y + t, color, grosor)
        linea(painter, x + t, y - t, x - t, y + t, color, grosor)
    }

    def circulo(QPainter painter, double x, double y, double radio, Color color /* =colores.negro*/, int grosor) {
        val pos = Utils.aAbsoluta(x, y)
        painter.pen = color.createPen(grosor)
        painter.drawEllipse(pos.x - radio, pos.y - radio, radio * 2, radio * 2)
    }

	def rectangulo(QPainter painter, int x, int y, int ancho, int alto) {
		rectangulo(painter, x, y, ancho, alto, Color.black, 1, false)
	}

	def rectangulo(QPainter painter, double x, double y, double ancho, double alto, Color color, int grosor) {
		rectangulo(painter, x, y, ancho, alto, color, grosor, false)
	}

    def rectangulo(QPainter painter, double x, double y, double ancho, double alto, Color color, int grosor, boolean fill) {
        painter.pen = color.createPen(grosor)
        if (fill)
        	painter.fillRect(Utils.aAbsoluta(x, y), ancho, alto, color)
        else 
        	painter.drawRect(Utils.aAbsoluta(x, y), ancho, alto)
    }
	
}