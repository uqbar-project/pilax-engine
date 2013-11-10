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

class QtExtensions {
	
	def static QPainter createQPainter() {
		val painter = new QPainter => [
			setRenderHint(QPainter.RenderHint.HighQualityAntialiasing, true)
        	setRenderHint(QPainter.RenderHint.SmoothPixmapTransform, true)
        	setRenderHint(QPainter.RenderHint.Antialiasing, true)
        ]
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
	
	def static isFullScreen(QKeyEvent event) {
		event.key == Qt.Key.Key_F && event.modifiers == Qt.KeyboardModifier.AltModifier
	}
	
	def static isPausa(QKeyEvent event) {
		event.key == Qt.Key.Key_P && event.modifiers == Qt.KeyboardModifier.AltModifier
	}
	
	def static isEscape(QKeyEvent event) {
		event.key == Qt.Key.Key_Escape
	}
	
}