package org.uqbar.pilax.motor.qt

import com.trolltech.qt.core.QEvent
import com.trolltech.qt.core.QPoint
import com.trolltech.qt.core.QRectF
import com.trolltech.qt.core.Qt
import com.trolltech.qt.core.Qt.KeyboardModifiers
import com.trolltech.qt.gui.QColor
import com.trolltech.qt.gui.QKeyEvent
import com.trolltech.qt.gui.QPainter
import com.trolltech.qt.gui.QPen
import com.trolltech.qt.gui.QPixmap
import java.awt.Color
import org.uqbar.pilax.geom.Area
import org.uqbar.pilax.motor.ImagenMotor
import org.uqbar.pilax.motor.PilasImage
import org.uqbar.pilax.motor.PilasPainter
import org.uqbar.pilax.utils.Utils

import static com.trolltech.qt.core.Qt.Key.*
import static com.trolltech.qt.core.Qt.KeyboardModifier.*

import static extension org.uqbar.pilax.utils.PilasExtensions.*

/**
 * 
 * @author jfernandes
 */
class QtExtensions {
	
	def static PilasPainter createPainter() { motor.createPainter }
	
	def static asQRect(Area a) {
		new QRectF(a.izquierda, a.derecha, a.arriba, a.abajo)
	}
	
	def static void scale(QPainter painter, double scale) {
		painter.scale(scale, scale)
	} 
	
	def static void fillRect(QPainter painter, Pair<Double,Double> point, Pair<Double,Double> size, Color color) {
		painter.fillRect(point.key.intValue, point.value.intValue, size.key.intValue, size.value.intValue, color.asQColor)
	}
	
	def static void fillRect(QPainter painter, Pair<Double,Double> point, double width, double height, Color color) {
		painter.fillRect(point.key.intValue, point.value.intValue, width.intValue, height.intValue, color.asQColor)
	}
	
	def static void drawRect(QPainter painter, Pair<Double,Double> point, double width, double height) {
		painter.drawRect(point.key.intValue, point.value.intValue, width.intValue, height.intValue)
	}
	
	def static void drawLine(QPainter painter, Pair<Double,Double> p1, Pair<Double,Double> p2) {
		painter.drawLine(p1.key.intValue, p1.value.intValue, p2.key.intValue, p2.value.intValue)
	}
	
	def static void drawText(QPainter painter, Pair<Double,Double> point, String text) {
		painter.drawText(point.key.intValue, point.value.intValue, text)
	} 
	
	def static void drawEllipse(QPainter p, double x, double y, double w, double h) {
		p.drawEllipse(x.intValue, y.intValue, w.intValue, h.intValue)
	}
	
	def static void drawTiledPixmap(QPainter painter, ImagenMotor imagen, double x, double y, double ancho, double alto){
		drawTiledPixmap(painter, (imagen.imagen as QTImage).image, x, y, ancho, alto)
	}
	
	def static void drawTiledPixmap(QPainter painter, QPixmap imagen, double x, double y, double ancho, double alto){
		val dx = x % imagen.width
        val dy = 0d
        painter.drawTiledPixmap(0, y.intValue, ancho.intValue, imagen.height, imagen, (Math.abs(dx) % imagen.width).intValue, (dy % imagen.height).intValue)
	}
	
	def static void drawTiledPixmap(QPainter painter, Pair<Double,Double> pos, Pair<Double,Double> size, QPixmap pixmap, Pair<Double,Double> pixmapTopLeft) {
		painter.drawTiledPixmap(pos.x.intValue, pos.y.intValue, size.x.intValue, size.y.intValue, pixmap, pixmapTopLeft.x.intValue, pixmapTopLeft.y.intValue)
	}
	
	def static QColor asQColor(Color color) {
		new QColor(color.red, color.green, color.blue, color.alpha)	
	}
	
	def static QPen createPen(Color color, int grosor) {
		new QPen(color.asQColor, grosor)		
	}
	
	def static QPoint operator_divide(QPoint p, double f) {
		p.divide(f)
	}
	
	def static QPoint operator_multiply(QPoint p, double f) {
		p.multiply(f)
	}
	
	def static Pair<Double,Double> aRelativa(QPoint p) {
		Utils.aRelativa(p.x, p.y)
	}
	
	// **************************************
	// ** Keyboard extensions
	// **************************************
	
	def static isFullScreen(QKeyEvent event) { event === Key_F + AltModifier }
	def static isPausa(QKeyEvent event) { event === Key_P + AltModifier }
	def static isEscape(QKeyEvent event) { event === Key_Escape }
	
	def static boolean operator_tripleEquals(QKeyEvent e1, QKeyEvent e2) {
		e1.type == e2.type && e1.key == e2.key && e1.modifiers == e2.modifiers
	}
	
	def static boolean operator_tripleEquals(QKeyEvent e1, Qt.Key key) {
		e1.key == key.value // TODO: and not modifiers !
	}
	
	def static QKeyEvent operator_plus(Qt.Key key, Qt.KeyboardModifier modifier) {
		new QKeyEvent(QEvent.Type.KeyPress, key.value, new KeyboardModifiers(modifier))
	}
	
	def static isKeyPressed(QKeyEvent event, Qt.Key key) {
		event.key == key.value
	}
	
	def static hasModifier(QKeyEvent event, Qt.KeyboardModifier modifier) {
		event.modifiers.isSet(modifier)
	}
	
	def static drawPixmap(PilasPainter painter, double x, double y, PilasImage pixmap, double dx, double dy, double ancho, double alto) {
		painter.drawPixmap(x.intValue,y.intValue, pixmap, dx.intValue, dy.intValue, ancho.intValue, alto.intValue)
	}
	
}