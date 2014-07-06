package org.uqbar.pilax.motor.java2d

import java.awt.Image
import java.awt.image.BufferedImage
import java.awt.image.ImageObserver
import java.io.File
import javax.imageio.ImageIO
import org.uqbar.pilax.motor.PilasImage

/**
 * @author jfernandes
 */
class Java2DImage implements PilasImage, ImageObserver {
	@Property BufferedImage image
	
	new(String fullPath) {
		this(ImageIO.read(new File(fullPath)))
	}
	
	new(BufferedImage img) {
		image = img
	}
	
	override getWidth() { image.getWidth(this) }
	
	override setWidth(double w) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getHeight() { image.getHeight(this) }
	
	override setHeight(double h) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override fill(int r, int g, int b, int alpha) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getBox(double d, double e, double f, double f2) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	// ** image observer
	
	override imageUpdate(Image img, int infoflags, int x, int y, int width, int height) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}