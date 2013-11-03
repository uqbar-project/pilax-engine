package org.uqbar.pilax.motor

import com.trolltech.qt.core.QRect
import com.trolltech.qt.core.Qt
import com.trolltech.qt.gui.QColor
import com.trolltech.qt.gui.QFont
import com.trolltech.qt.gui.QFontMetrics
import com.trolltech.qt.gui.QPainter
import com.trolltech.qt.gui.QPen
import com.trolltech.qt.gui.QPixmap
import java.awt.Color
import java.util.List
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.engine.TextoMotor
import org.uqbar.pilax.engine.motor.ImagenMotor

import static extension org.uqbar.pilax.engine.PilasExtensions.*
import static extension org.uqbar.pilax.engine.PythonUtils.*

class Superficie extends ImagenMotor {
	@Property QPainter canvas
	
	new(int ancho, int alto) {
		self.imagen = new QPixmap(ancho, alto)
        self.imagen.fill(new QColor(255, 255, 255, 0))
        self.canvas = new QPainter()
        self.ruta = urandom(25)//os.urandom(25)
    }

    def pintar(Color color) {
        self.imagen.fill(color.asQColor)
	}
	
    def pintar_parte_de_imagen(ImagenMotor imagen, int origen_x, int origen_y, int ancho, int alto, int x, int y) {
        self.canvas.begin(self.imagen)
        self.canvas.drawPixmap(x, y, imagen.imagen, origen_x, origen_y, ancho, alto)
        self.canvas.end()
    }

	def pintar_imagen(ImagenMotor imagen) {
		pintar_imagen(imagen, 0, 0)
	}

    def pintar_imagen(ImagenMotor imagen, int x, int y) {
        self.pintar_parte_de_imagen(imagen, 0, 0, imagen.ancho(), imagen.alto(), x, y)
	}
	
	def texto(String cadena) {
		texto(cadena, 0, 0)
	}
	
	def texto(String cadena, int x, int y) {
		texto(cadena, x, y, 10, null, Color.BLACK)
	}
	
    def texto(String cadena, int x, int y, int magnitud, String fuente, Color color) {
    	//TODO: esto parece duplicado de Texto o algo asi
        self.canvas.begin(self.imagen)
        self.canvas.setPen(color.asQColor)
        val dx = x
        var dy = y
	
        val nombre_de_fuente = if (fuente != null)
            						TextoMotor.cargar_fuente_desde_cache(fuente)
        						else
            						self.canvas.font().family()

        val font = new QFont(nombre_de_fuente, magnitud)
        self.canvas.setFont(font)
        val metrica = new QFontMetrics(font)

        for (line : cadena.split('\n')) {
        	val rect = new QRect(dx, dy, imagen.width(), imagen.height())
        	var flags = Qt.AlignmentFlag.AlignLeft.value || Qt.AlignmentFlag.AlignTop.value
            self.canvas.drawText(rect, flags, line)
            dy = dy + metrica.height
        }

        canvas.end()
	}
	
	def circulo(int x, int y, int radio) {
		circulo(x, y, radio, Color.BLACK, false, 1)
	}
	
    def circulo(int x, int y, int radio, Color color, boolean relleno, int grosor) {
        canvas.begin(imagen)

        val pen = new QPen(color.asQColor, grosor)
        canvas.setPen(pen)

        if (relleno)
            canvas.setBrush(color.asQColor)

        canvas.drawEllipse(x-radio, y-radio, radio*2, radio*2)
        canvas.end()
	}
	
	def rectangulo(int x, int y, int ancho, int alto) {
		rectangulo(x, y, ancho, alto, Color.BLACK, false, 1)
	}
	
    def rectangulo(int x, int y, int ancho, int alto, Color color, boolean relleno, int grosor) {
        canvas.begin(imagen)

        val pen = new QPen(color.asQColor, grosor)
        self.canvas.setPen(pen)

        if (relleno)
            self.canvas.setBrush(color.asQColor)

        self.canvas.drawRect(x, y, ancho, alto)
        self.canvas.end()
	}
	
	def linea(int x, int y, int x2, int y2) {
		linea(x,y, x2, y2, Color.BLACK, 1)
	}
	
    def linea(int x, int y, int x2, int y2, Color color, int grosor) {
        self.canvas.begin(imagen)

        val pen = new QPen(color.asQColor, grosor)
        self.canvas.setPen(pen)

        self.canvas.drawLine(x, y, x2, y2)
        self.canvas.end()
	}
	
	def poligono(List<Pair<Integer,Integer>> puntos, Color color, int grosor) {
		poligono(puntos, color, grosor, false)
	}
	
    def poligono(List<Pair<Integer,Integer>> puntos, Color color, int grosor, boolean cerrado) {
        var x = puntos.get(0).key
        var y = puntos.get(0).value

        if (cerrado)
            puntos.add((x -> y))

        for (p : puntos.subList(1)) {
            var nuevo_x = p.x
            var nuevo_y = p.y
            self.linea(x, y, nuevo_x, nuevo_y, color, grosor)
            x = nuevo_x
            y = nuevo_y
        }
	}

	def dibujar_punto(int x, int y) {
		dibujar_punto(x, y, Color.BLACK)
	} 

    def dibujar_punto(int x, int y, Color color) {
        circulo(x, y, 3, color, true, 1)
	}
	
    def limpiar() {
        imagen.fill(new QColor(0, 0, 0, 0))
	}
	
}