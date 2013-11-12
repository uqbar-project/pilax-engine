package org.uqbar.pilax.motor.qt

import com.trolltech.qt.core.QPoint
import com.trolltech.qt.gui.QColor
import java.awt.Color
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.utils.Utils
import com.trolltech.qt.gui.QKeyEvent
import com.trolltech.qt.core.Qt
import com.trolltech.qt.gui.QPen
import com.trolltech.qt.gui.QPainter
import com.trolltech.qt.core.QEvent.Type
import com.trolltech.qt.core.QEvent
import com.trolltech.qt.core.Qt.KeyboardModifiers

import static com.trolltech.qt.core.Qt.Key.*
import static com.trolltech.qt.core.Qt.KeyboardModifier.*

class QtExtensions {
	
	def static void scale(QPainter painter, double scale) {
		painter.scale(scale, scale)
	} 
	
	def static void fillRect(QPainter painter, Pair<Integer,Integer> point, Pair<Integer,Integer> size, Color color) {
		painter.fillRect(point.key, point.value, size.key, size.value, color.asQColor)
	}
	
	def static void drawRect(QPainter painter, Pair<Integer,Integer> point, int width, int height) {
		painter.drawRect(point.key, point.value, width, height)
	}
	
	def static void drawLine(QPainter painter, Pair<Integer,Integer> p1, Pair<Integer,Integer> p2) {
		painter.drawLine(p1.key, p1.value, p2.key, p2.value)
	}
	
	def static void drawText(QPainter painter, Pair<Integer,Integer> point, String text) {
		painter.drawText(point.key, point.value, text)
	} 
	
	def static QPainter createQPainter() {
		val painter = new QPainter /*  => [
			setRenderHint(QPainter.RenderHint.HighQualityAntialiasing, true)
        	setRenderHint(QPainter.RenderHint.SmoothPixmapTransform, true)
        	setRenderHint(QPainter.RenderHint.Antialiasing, true)
        ]*/
        painter
	}
	
	def static QColor asQColor(Color color) {
		new QColor(color.red, color.green, color.blue, color.alpha)	
	}
	
	def static QPen createPen(Color color, int grosor) {
		new QPen(color.asQColor, grosor)		
	}
	
	def static QPoint operator_divide(QPoint p, float f) {
		p.divide(f)
	}
	
	def static QPoint operator_multiply(QPoint p, float f) {
		p.multiply(f)
	}
	
	def static Pair<Float,Float> aRelativa(QPoint p) {
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
	
}