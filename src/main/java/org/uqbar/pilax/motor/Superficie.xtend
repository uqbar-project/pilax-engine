package org.uqbar.pilax.motor

import java.awt.Color
import java.util.List
import org.uqbar.pilax.actores.interfaz.Canvas

import static org.uqbar.pilax.utils.PythonUtils.*

import static extension org.uqbar.pilax.motor.qt.QtExtensions.*
import static extension org.uqbar.pilax.utils.PilasExtensions.*

/**
 * @author jfernandes
 */
class Superficie extends ImagenMotor implements Canvas {
	@Property PilasPainter canvas
	
	new(double ancho, double alto) {
		imagen = motor.createImage(ancho.intValue, alto.intValue)
        imagen.fill(255, 255, 255, 0)
        canvas = createPainter
        ruta = urandom(25)
    }

    def pintar(Color color) {
        imagen.fill(color.red, color.green, color.blue, color.alpha)
	}
	
    override pintarParteDeImagen(ImagenMotor imagen, double origen_x, double origen_y, double ancho, double alto, double x, double y) {
        canvas => [
        	begin(this.imagen)
        	drawPixmap(x, y, imagen.imagen, origen_x, origen_y, ancho, alto)
        	end
       	]
    }

	def pintar_imagen(ImagenMotor imagen) {
		pintar_imagen(imagen, 0, 0)
	}

    def pintar_imagen(ImagenMotor imagen, double x, double y) {
        pintarParteDeImagen(imagen, 0, 0, imagen.ancho, imagen.alto, x, y)
	}
	
	def texto(String cadena) { texto(cadena, 0, 0) }
	def texto(String cadena, int x, int y) { texto(cadena, x, y, 10) }
	def texto(String cadena, int x, int y, int magnitud) { texto(cadena, x, y, magnitud, null, Color.BLACK) }
	def texto(String cadena, int x, int y, int magnitud, String fuente, Color color) { canvas.drawText(imagen, cadena, x, y, magnitud, fuente, color) }
	
	def circulo(int x, int y, int radio) { circulo(x, y, radio, Color.BLACK, false, 1) }
	def circulo(int x, int y, int radio, Color color, boolean relleno, int grosor) {
        canvas.drawCircle(imagen, x, y, radio, color, relleno, grosor)
	}
	
	def rectangulo(int x, int y, int ancho, int alto) {
		rectangulo(x, y, ancho, alto, Color.BLACK, false, 1)
	}
	
    def rectangulo(int x, int y, int ancho, int alto, Color color, boolean relleno, int grosor) {
    	canvas.drawRect(imagen, x, y, ancho, alto, color, relleno, grosor)
	}
	
	def linea(int x, int y, int x2, int y2) { linea(x,y, x2, y2, Color.BLACK, 1) }
	def linea(int x, int y, int x2, int y2, Color color, int grosor) { canvas.drawLine(imagen, x, y, x2, y2, color, grosor) }
	
	def poligono(List<Pair<Integer,Integer>> puntos, Color color, int grosor) { poligono(puntos, color, grosor, false) }
    def poligono(List<Pair<Integer,Integer>> puntos, Color color, int grosor, boolean cerrado) {
        var x = puntos.get(0).x
        var y = puntos.get(0).y

        if (cerrado)
            puntos.add((x -> y))

        for (p : puntos.subList(1)) {
            var nuevo_x = p.x
            var nuevo_y = p.y
            linea(x, y, nuevo_x, nuevo_y, color, grosor)
            x = nuevo_x
            y = nuevo_y
        }
	}

	def dibujar_punto(int x, int y) { dibujar_punto(x, y, Color.BLACK) } 
    def dibujar_punto(int x, int y, Color color) { circulo(x, y, 3, color, true, 1) }
    def dibujarPunto(double x, double y) { dibujarPunto(x, y, Color.black) }
    def dibujarPunto(double x, double y, Color color) { circulo(x.intValue, y.intValue, 3, color, true, 1) }
	
    def limpiar() {
        imagen.fill(0, 0, 0, 0)
	}
	
	def obtener_recuadro(double dx, double dy, double ancho, double alto) {
		imagen.getBox(dx, dy, ancho, alto)
    }
	
}