package org.uqbar.pilax.motor.java2d

import java.awt.AlphaComposite
import java.awt.Color
import java.awt.Graphics
import java.awt.Graphics2D
import java.awt.image.ImageObserver
import org.uqbar.pilax.motor.PilasImage
import org.uqbar.pilax.motor.PilasPainter
import java.awt.Image
import java.awt.TexturePaint
import java.awt.Rectangle

/**
 * @author jfernandes
 */
class Java2DPainter implements PilasPainter, ImageObserver {
	Graphics2D graphics
	
	new(Graphics graphics) {
		this.graphics = graphics as Graphics2D
	}
	
	override begin(PilasImage widget) {}
	override end() {}
	override save() {}
	override restore() {}
	
	override translate(double dx, double dy) {
		graphics.translate(dx, dy) // deberia ser el otro translate ?
	}
	
	override rotate(double r) { graphics.rotate(r) }
	override scale(double dx, double dy) { graphics.scale(dx, dy) }
	
	override setOpacity(double o) { graphics.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER, o.floatValue)) }
	
	override drawPixmap(int x, int y, PilasImage image) {
		graphics.drawImage(image.to2dImage, x, y, image.width.intValue, image.height.intValue, this)
	}
	
	def to2dImage(PilasImage img) { (img as Java2DImage).image }
	
	override drawPixmap(int x, int y, PilasImage imagen, int dx, int dy, int cuadroAncho, int cuadroAlto) {
		drawPixmap(x, y, imagen) //TODO !
	}
	
	override drawRect(PilasImage i, int x, int y, int width, int height, Color color, boolean fill, int tickness) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override drawCircle(PilasImage image, int x, int y, int radius, Color color, boolean fill, int tickness) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override drawLine(PilasImage imagen, int x, int y, int x2, int y2, Color color, int grosor) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override drawLine(Pair<Double, Double> p1, Pair<Double, Double> p2) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override drawText(PilasImage image, String text, int x, int y, int size, String font, Color color) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override drawMultiLineText(String text, double dx, double dy, int size, String font, Color color, int height) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override drawAbsoluteText(String text, double x, double y, int size, String font, Color color) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override drawTiledPixmap(Pair<Double, Double> origen, Pair<Double, Double> area, PilasImage image, Pair<Double, Double> imageTopLeft) {
		val rect = new Rectangle(origen.key.intValue, origen.value.intValue, 30, 30)
		graphics.paint = new TexturePaint(image.to2dImage, rect)
		graphics.fillRect(origen.key.intValue, origen.value.intValue, 
			origen.key.intValue + area.key.intValue,
			origen.value.intValue + area.value.intValue
		)
	}
	
	override drawTiledPixmap(PilasImage image, int x, int y, int ancho, int alto) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override setPen(Color color, int i) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override fillRect(Pair<Double, Double> p1, Pair<Double, Double> p2, Color color) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override drawEllipse(double x, double y, double w, double h) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override fillRect(Pair<Double, Double> p, double w, double h, Color color) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override drawRect(Pair<Double, Double> xy, double ancho, double alto) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	// ********* image observer
	
	override imageUpdate(Image img, int infoflags, int x, int y, int width, int height) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}