package org.uqbar.pilax.engine.motor;

import com.trolltech.qt.core.QSize;
import com.trolltech.qt.gui.QPainter;
import com.trolltech.qt.gui.QPixmap;
import org.eclipse.xtext.xbase.lib.Pair;
import org.uqbar.pilax.engine.Motor;
import org.uqbar.pilax.engine.Mundo;
import org.uqbar.pilax.engine.Pilas;
import org.uqbar.pilax.engine.PilasExtensions;
import org.uqbar.pilax.engine.PythonUtils;

@SuppressWarnings("all")
public class ImagenMotor {
  private QPixmap _imagen;
  
  public QPixmap getImagen() {
    return this._imagen;
  }
  
  public void setImagen(final QPixmap imagen) {
    this._imagen = imagen;
  }
  
  private String ruta;
  
  public ImagenMotor(final String path) {
    String _resolveFullPathFromClassPath = PilasExtensions.resolveFullPathFromClassPath(path);
    this.ruta = _resolveFullPathFromClassPath;
    boolean _or = false;
    String _lowerCase = this.ruta.toLowerCase();
    boolean _endsWith = _lowerCase.endsWith("jpeg");
    if (_endsWith) {
      _or = true;
    } else {
      String _lowerCase_1 = this.ruta.toLowerCase();
      boolean _endsWith_1 = _lowerCase_1.endsWith("jpg");
      _or = (_endsWith || _endsWith_1);
    }
    if (_or) {
      ImagenMotor _self = PythonUtils.<ImagenMotor>self(this);
      ImagenMotor _self_1 = PythonUtils.<ImagenMotor>self(this);
      QPixmap _cargarJpeg = _self_1.cargarJpeg(this.ruta);
      _self.setImagen(_cargarJpeg);
    } else {
      ImagenMotor _self_2 = PythonUtils.<ImagenMotor>self(this);
      QPixmap _qPixmap = new QPixmap(this.ruta);
      _self_2.setImagen(_qPixmap);
    }
  }
  
  public QPixmap cargarJpeg(final String ruta) {
    UnsupportedOperationException _unsupportedOperationException = new UnsupportedOperationException("Needs to implement support for jpg");
    throw _unsupportedOperationException;
  }
  
  /**
   * Dibuja la imagen sobre la ventana que muestra el motor.
   *  x, y: indican la posicion dentro del mundo.
   *  dx, dy: es el punto centro de la imagen (importante para rotaciones).
   *  escala_x, escala_yindican cambio de tamano (1 significa normal).
   *  rotacion: angulo de inclinacion en sentido de las agujas del reloj.
   */
  public void dibujar(final QPainter painter, final int x, final int y, final int dx, final int dy, final int escala_x, final int escala_y, final int rotacion, final int transparencia) {
    painter.save();
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    Motor _motor = _mundo.getMotor();
    final Pair<Integer,Integer> centro = _motor.centroFisico();
    Integer _key = centro.getKey();
    int _plus = (x + (_key).intValue());
    Integer _value = centro.getValue();
    int _minus = ((_value).intValue() - y);
    painter.translate(_plus, _minus);
    painter.rotate(rotacion);
    painter.scale(escala_x, escala_y);
    boolean _notEquals = (transparencia != 0);
    if (_notEquals) {
      double _divide = (transparencia / 100.0);
      double _minus_1 = (1 - _divide);
      painter.setOpacity(_minus_1);
    }
    ImagenMotor _self = PythonUtils.<ImagenMotor>self(this);
    int _minus_2 = (-dx);
    int _minus_3 = (-dy);
    _self.dibujarPixmap(painter, _minus_2, _minus_3);
    painter.restore();
  }
  
  private void dibujarPixmap(final QPainter painter, final int x, final int y) {
    ImagenMotor _self = PythonUtils.<ImagenMotor>self(this);
    QPixmap _imagen = _self.getImagen();
    painter.drawPixmap(x, y, _imagen);
  }
  
  public int ancho() {
    ImagenMotor _self = PythonUtils.<ImagenMotor>self(this);
    QPixmap _imagen = _self.getImagen();
    QSize _size = _imagen.size();
    int _width = _size.width();
    return _width;
  }
  
  public int alto() {
    ImagenMotor _self = PythonUtils.<ImagenMotor>self(this);
    QPixmap _imagen = _self.getImagen();
    QSize _size = _imagen.size();
    int _height = _size.height();
    return _height;
  }
  
  /**
   * Retorna una tupla con la coordenada del punto medio del la imagen.
   */
  public Pair<Integer,Integer> centro() {
    ImagenMotor _self = PythonUtils.<ImagenMotor>self(this);
    int _ancho = _self.ancho();
    int _divide = (_ancho / 2);
    ImagenMotor _self_1 = PythonUtils.<ImagenMotor>self(this);
    int _alto = _self_1.alto();
    int _divide_1 = (_alto / 2);
    Pair<Integer,Integer> _mappedTo = Pair.<Integer, Integer>of(Integer.valueOf(_divide), Integer.valueOf(_divide_1));
    return _mappedTo;
  }
  
  public Object avanzar() {
    return null;
  }
}
