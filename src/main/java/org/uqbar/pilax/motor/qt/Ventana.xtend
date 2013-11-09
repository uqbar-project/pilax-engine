package org.uqbar.pilax.motor.qt

import com.trolltech.qt.gui.QMainWindow
import com.trolltech.qt.gui.QResizeEvent

/**
 * 
 */
class Ventana extends QMainWindow {
	CanvasNormalWidget canvas
	
	new(Ventana padre) {
		super(padre)
	}
	
	def void setCanvas(CanvasNormalWidget canvas) {
        this.canvas = canvas
        this.canvas.parent = this
    }
    
	override protected resizeEvent(QResizeEvent event) {
        canvas.resize_to(width, height)
    }
	
}