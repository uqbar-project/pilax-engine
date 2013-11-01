package org.uqbar.pilax.engine.motor;

import com.trolltech.qt.gui.QPainter;
import org.uqbar.pilax.engine.Motor;
import org.uqbar.pilax.engine.Mundo;
import org.uqbar.pilax.engine.Pilas;
import org.uqbar.pilax.engine.PythonUtils;
import org.uqbar.pilax.engine.motor.ActorBaseMotor;
import org.uqbar.pilax.engine.motor.ImagenMotor;

@SuppressWarnings("all")
public class ActorMotor extends ActorBaseMotor {
  private ImagenMotor _imagen;
  
  public ImagenMotor getImagen() {
    return this._imagen;
  }
  
  public void setImagen(final ImagenMotor imagen) {
    this._imagen = imagen;
  }
  
  public ActorMotor(final String imagen, final int x, final int y) {
    super(x, y);
    ImagenMotor _cargarImagen = this.cargarImagen(imagen);
    this.setImagen(_cargarImagen);
  }
  
  public ImagenMotor cargarImagen(final String path) {
    ImagenMotor _imagenMotor = new ImagenMotor(path);
    return _imagenMotor;
  }
  
  public void dibujar(final QPainter painter) {
    ActorMotor _self = PythonUtils.<ActorMotor>self(this);
    int escala_x = _self.getEscala_x();
    ActorMotor _self_1 = PythonUtils.<ActorMotor>self(this);
    int escala_y = _self_1.getEscala_y();
    ActorMotor _self_2 = PythonUtils.<ActorMotor>self(this);
    boolean _isEspejado = _self_2.isEspejado();
    if (_isEspejado) {
      int _minus = (-1);
      int _multiply = (escala_x * _minus);
      escala_x = _multiply;
    }
    int dx = 0;
    int dy = 0;
    ActorMotor _self_3 = PythonUtils.<ActorMotor>self(this);
    int _fijo = _self_3.getFijo();
    boolean _equals = (_fijo == 0);
    if (_equals) {
      Pilas _instance = Pilas.instance();
      Mundo _mundo = _instance.getMundo();
      Motor _motor = _mundo.getMotor();
      int _camaraX = _motor.getCamaraX();
      dx = _camaraX;
      Pilas _instance_1 = Pilas.instance();
      Mundo _mundo_1 = _instance_1.getMundo();
      Motor _motor_1 = _mundo_1.getMotor();
      int _camaraY = _motor_1.getCamaraY();
      dy = _camaraY;
    } else {
      dx = 0;
      dy = 0;
    }
    ActorMotor _self_4 = PythonUtils.<ActorMotor>self(this);
    int _x = _self_4.getX();
    int _minus_1 = (_x - dx);
    this.setX(_minus_1);
    ActorMotor _self_5 = PythonUtils.<ActorMotor>self(this);
    int _y = _self_5.getY();
    int _minus_2 = (_y - dy);
    this.setY(_minus_2);
    ActorMotor _self_6 = PythonUtils.<ActorMotor>self(this);
    ImagenMotor _imagen = _self_6.getImagen();
    int _x_1 = this.getX();
    int _y_1 = this.getY();
    ActorMotor _self_7 = PythonUtils.<ActorMotor>self(this);
    int _centro_x = _self_7.getCentro_x();
    ActorMotor _self_8 = PythonUtils.<ActorMotor>self(this);
    int _centro_y = _self_8.getCentro_y();
    ActorMotor _self_9 = PythonUtils.<ActorMotor>self(this);
    int _rotacion = _self_9.getRotacion();
    ActorMotor _self_10 = PythonUtils.<ActorMotor>self(this);
    int _transparencia = _self_10.getTransparencia();
    _imagen.dibujar(painter, _x_1, _y_1, _centro_x, _centro_y, escala_x, escala_y, _rotacion, _transparencia);
  }
}
