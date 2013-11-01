package org.uqbar.pilax.engine;

import com.trolltech.qt.gui.QMainWindow;
import com.trolltech.qt.gui.QResizeEvent;
import org.uqbar.pilax.engine.CanvasNormalWidget;

@SuppressWarnings("all")
public class Ventana extends QMainWindow {
  private CanvasNormalWidget canvas;
  
  public Ventana(final Ventana padre) {
    super(padre);
  }
  
  public void setCanvas(final CanvasNormalWidget canvas) {
    this.canvas = canvas;
    this.canvas.setParent(this);
  }
  
  protected void resizeEvent(final QResizeEvent event) {
    int _width = this.width();
    int _height = this.height();
    this.canvas.resize_to(_width, _height);
  }
}
