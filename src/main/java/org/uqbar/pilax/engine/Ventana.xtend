package org.uqbar.pilax.engine

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
	
	def setCanvas(CanvasNormalWidget canvas) {
        this.canvas = canvas
        this.canvas.setParent(this)
    }
    
	override protected resizeEvent(QResizeEvent event) {
        this.canvas.resize_to(this.width(), this.height())
    }
	
}