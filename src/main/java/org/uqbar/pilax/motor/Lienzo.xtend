package org.uqbar.pilax.motor

import com.trolltech.qt.gui.QFont
import com.trolltech.qt.gui.QPainter
import java.awt.Color
import javax.swing.Painter
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.utils.Utils

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*
import static extension org.uqbar.pilax.utils.Utils.*
import com.trolltech.qt.gui.QPen

class Lienzo extends ImagenMotor {
    
    def texto(QPainter painter, String cadena) {
    	texto(painter, cadena, 0, 0, 10, null, Color.BLACK)
    }
    
    /** Imprime un texto respespetando el desplazamiento de la camara. */
    def texto(QPainter painter, String cadena, int x, int y, int magnitud, String fuente, Color color) {
        texto_absoluto(painter, cadena, x, y, magnitud, fuente, color)
    }

	def texto_absoluto(QPainter painter, String cadena, int x, int y, Color color) {
		texto_absoluto(painter, cadena, x, y, 10, null, color)
	}

    /** Imprime un texto sin respetar al camara.*/
    def texto_absoluto(QPainter painter, String cadena, int x, int y, int magnitud, String fuente, Color color) {
        val coordenada = Utils.hacer_coordenada_pantalla_absoluta(x, y)

        painter.pen = color.asQColor

		val nombre_de_fuente = if (fuente != null) TextoMotor.cargar_fuente_desde_cache(fuente) else painter.font().family() 

        val font = new QFont(nombre_de_fuente, magnitud)
        painter.setFont(font)
        painter.drawText(coordenada.x, coordenada.y, cadena)
	}
	
    def pintar(QPainter painter, Color color) {
        val area = Pilas.instance.mundo.area
        painter.fillRect(0, 0, area.ancho, area.alto, color.asQColor)
    }

//    def linea(self, Painter, x0, y0, x1, y1, Color=colores.negro, grosor=1):
//        x0, y0 = utils.hacer_coordenada_pantalla_absoluta(x0, y0)
//        x1, y1 = utils.hacer_coordenada_pantalla_absoluta(x1, y1)
//
//        r, g, b, a = color.obtener_componentes()
//        color = QtGui.QColor(r, g, b)
//        pen = QtGui.QPen(color, grosor)
//        painter.setPen(pen)
//        painter.drawLine(x0, y0, x1, y1)
//
//    def poligono(self, motor, puntos, color=colores.negro, grosor=1, cerrado=False):
//        x, y = puntos[0]
//        if cerrado:
//            puntos.append((x, y))
//
//        for p in puntos[1:]:
//            nuevo_x, nuevo_y = p
//            self.linea(motor, x, y, nuevo_x, nuevo_y, color, grosor)
//            x, y = nuevo_x, nuevo_y
//
//    def cruz(self, painter, x, y, color=colores.negro, grosor=1):
//        t = 3
//        self.linea(painter, x - t, y - t, x + t, y + t, color, grosor)
//        self.linea(painter, x + t, y - t, x - t, y + t, color, grosor)
//
//    def circulo(self, painter, x, y, radio, color=colores.negro, grosor=1):
//        x, y = utils.hacer_coordenada_pantalla_absoluta(x, y)
//
//        r, g, b, a = color.obtener_componentes()
//        color = QtGui.QColor(r, g, b)
//        pen = QtGui.QPen(color, grosor)
//        painter.setPen(pen)
//        painter.drawEllipse(x-radio, y-radio, radio*2, radio*2)
//
	def rectangulo(QPainter painter, int x, int y, int ancho, int alto) {
		rectangulo(painter, x, y, ancho, alto, Color.black, 1)
	}

    def rectangulo(QPainter painter, int x, int y, int ancho, int alto, Color color, int grosor) {
        val coordenada = Utils.hacer_coordenada_pantalla_absoluta(x, y)
        painter.setPen(new QPen(color.asQColor, grosor))
        painter.drawRect(coordenada.x, coordenada.y, ancho, alto)
    }
	
}