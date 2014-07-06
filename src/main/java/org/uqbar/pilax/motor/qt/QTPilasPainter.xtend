package org.uqbar.pilax.motor.qt

import com.trolltech.qt.core.QRect
import com.trolltech.qt.core.Qt
import com.trolltech.qt.gui.QColor
import com.trolltech.qt.gui.QFont
import com.trolltech.qt.gui.QFontMetrics
import com.trolltech.qt.gui.QPaintDeviceInterface
import com.trolltech.qt.gui.QPainter
import com.trolltech.qt.gui.QPen
import java.awt.Color
import org.uqbar.pilax.motor.PilasImage
import org.uqbar.pilax.motor.PilasPainter
import org.uqbar.pilax.utils.Utils

import static extension org.uqbar.pilax.motor.qt.QtExtensions.*

/**
 * Adapter para QT. 
 * 
 * @author jfernandes
 */
class QTPilasPainter implements PilasPainter {
	var QPainter p
	new(QPainter pa) { p = pa }
	
	// solo para uso interno
	def getQPainter() { p }
	
	override begin(PilasImage widget) { p.begin((widget as QTPaintDeviceInterfaceWrapper).asQPaintDeviceInterface) }
	override end() { p.end }
	
	override save() { p.save }
	override restore() { p.restore }
	override translate(double dx, double dy) { p.translate(dx, dy) }
	override rotate(double r) { p.rotate(r) }
	override scale(double dx, double dy) { p.scale(dx, dy) }
	override setOpacity(double o) { p.opacity = o }
	
	override drawPixmap(int x, int y, PilasImage image) { p.drawPixmap(x, y, image.qtImage) }
	override drawPixmap(int x, int y, PilasImage imagen, int dx, int dy, int cuadroAncho, int cuadroAlto) {
		p.drawPixmap(x, y, imagen.qtImage, dx, dy, cuadroAncho, cuadroAlto)
	}
	
	def qtImage(PilasImage i) { (i as QTImage).image }
	
	override drawRect(PilasImage device, int x, int y, int width, int height, Color color, boolean fill, int tickness) {
		p =>[
        	p.begin((device as QTPaintDeviceInterfaceWrapper).asQPaintDeviceInterface)
        	pen = color.createPen(tickness)
        	if (fill)
            	brush = color.asQColor
            drawRect(x, y, width, height)
        	end
        ]
	}
	
	override drawCircle(PilasImage image, int x, int y, int radius, Color color, boolean fill, int tickness) {
		begin(image)
        pen = color.createPen(tickness)
        if (fill)
            brush = color.asQColor
        p.drawEllipse(x - radius, y - radius, radius * 2, radius * 2)
        end
	}
	
	def setPen(QPen pen) { p.pen = pen }
	override setPen(Color color, int tickness) {
		pen = color.createPen(tickness)
	} 
	
	def setBrush(QColor color) { p.brush = color }
	
	override drawLine(PilasImage imagen, int x, int y, int x2, int y2, Color color, int grosor) {
       	begin(imagen)
       	pen = color.createPen(grosor)
       	p.drawLine(x, y, x2, y2)
       	end
	}
	
	override drawText(PilasImage image, String text, int x, int y, int size, String font, Color color) {
		begin(image)
        p.pen = color.asQColor
        var dy = y
	
        val nombre_de_fuente = if (font != null)
            						MotorQT.cargar_fuente_desde_cache(font)
        						else
            						p.font.family

        val qfont = new QFont(nombre_de_fuente, size)
        p.font = qfont
        val metrica = new QFontMetrics(qfont)

        for (line : text.split('\n')) {
        	val rect = new QRect(x, dy, image.width.intValue, image.height.intValue)
        	var flags = Qt.AlignmentFlag.AlignLeft.value.bitwiseOr(Qt.AlignmentFlag.AlignTop.value)
            p.drawText(rect, flags, line)
            dy = dy + metrica.height
        }

        p.end
	}
	
	override drawMultiLineText(String text, double dx, double dy, int size, String font, Color color, int alto) {
		val nombre_de_fuente = if (font != null) 
        							MotorQT.cargar_fuente_desde_cache(font)
        						else
            						p.font.family

        val laFuente = new QFont(nombre_de_fuente, size)
        val metrica = new QFontMetrics(laFuente)

       	p.pen = color.asQColor
        p.font = laFuente

		val lines = text.split('\n')

		var auxdy = dy
        for (line : lines) {
            p.drawText(dx.intValue, (auxdy + alto).intValue, line)
            auxdy = auxdy + metrica.height
        }
	}
	
	override drawAbsoluteText(String text, double x, double y, int size, String font, Color color) {
		p.pen = color.asQColor
		val nombre_de_fuente = if (font != null) MotorQT.cargar_fuente_desde_cache(font) else p.font.family
        p.font = new QFont(nombre_de_fuente, size)
        p.drawText(Utils.aAbsoluta(x, y), text)
	}
		
	override drawTiledPixmap(Pair<Double, Double> origen, Pair<Double, Double> area, PilasImage image, Pair<Double, Double> dontKnow) {
		p.save
        p.drawTiledPixmap(origen, area, image.qtImage, dontKnow)
        p.restore
	}
	
	override drawTiledPixmap(PilasImage image, int x, int y, int ancho, int alto) {
		p.drawTiledPixmap(image.qtImage, x, y, ancho, alto)
	}
	
	override drawLine(Pair<Double, Double> p1, Pair<Double, Double> p2) { p.drawLine(p1, p2) }
	
	override fillRect(Pair<Double, Double> p1, Pair<Double, Double> p2, Color color) { 
		p.fillRect(p1, p2, color)
	}
	
	override drawEllipse(double x, double y, double w, double h) {
		p.drawEllipse(x, y, w, h)
	}
	
	override fillRect(Pair<Double, Double> xy, double w, double h, Color color) {
		p.fillRect(xy, w, h, color)
	}
	
	override drawRect(Pair<Double, Double> xy, double ancho, double alto) {
		p.drawRect(xy, ancho, alto)
	}
	
}

interface QTPaintDeviceInterfaceWrapper {
	def QPaintDeviceInterface asQPaintDeviceInterface()
}