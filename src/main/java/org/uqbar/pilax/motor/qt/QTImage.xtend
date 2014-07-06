package org.uqbar.pilax.motor.qt

import com.trolltech.qt.core.QRect
import com.trolltech.qt.gui.QColor
import com.trolltech.qt.gui.QPixmap
import org.uqbar.pilax.motor.ImagenMotor
import org.uqbar.pilax.motor.PilasImage

/**
 * 
 */
class QTImage implements PilasImage, QTPaintDeviceInterfaceWrapper {
	@Property QPixmap image
	new(QPixmap image) { this.image = image }
	
	override getWidth() { image.size.width }
	override setWidth(double w) { image.size.width = w.intValue }
	
	override getHeight() { image.size.height }
	override setHeight(double h) { image.size.height = h.intValue }
	
	override fill(int r, int g, int b, int alpha) {
		image.fill(new QColor(r, g, b, alpha))
	}
	
	override asQPaintDeviceInterface() { image }
	
	override getBox(double dx, double dy, double width, double height) {
		val qi = image.toImage()
        val rect = new QRect(dx.intValue, dy.intValue, width.intValue, height.intValue)
        val qii = qi.copy(rect)
        return new ImagenMotor(new QTImage(QPixmap.fromImage(qii)))
	}
	
}