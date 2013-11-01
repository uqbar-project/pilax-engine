package org.uqbar.pilax.engine;

import com.trolltech.qt.gui.QPainter;
import com.trolltech.qt.gui.QPixmap;
import org.eclipse.xtext.xbase.lib.Pair;
import org.uqbar.pilax.engine.Fondo;
import org.uqbar.pilax.engine.Motor;
import org.uqbar.pilax.engine.Mundo;
import org.uqbar.pilax.engine.Pilas;
import org.uqbar.pilax.engine.motor.ImagenMotor;

@SuppressWarnings("all")
public class FondoPlano extends Fondo {
  public FondoPlano() {
    super("plano.png");
  }
  
  public void dibujar(final QPainter painter) {
    painter.save();
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    Motor _motor = _mundo.getMotor();
    int _camaraX = _motor.getCamaraX();
    this.setX(_camaraX);
    Pilas _instance_1 = Pilas.instance();
    Mundo _mundo_1 = _instance_1.getMundo();
    Motor _motor_1 = _mundo_1.getMotor();
    int _camaraY = _motor_1.getCamaraY();
    int _minus = (-_camaraY);
    this.setY(_minus);
    Pilas _instance_2 = Pilas.instance();
    Mundo _mundo_2 = _instance_2.getMundo();
    Motor _motor_2 = _mundo_2.getMotor();
    final Pair<Integer,Integer> area = _motor_2.getArea();
    final Integer ancho = area.getKey();
    final Integer alto = area.getValue();
    ImagenMotor _imagen = this.getImagen();
    QPixmap _imagen_1 = _imagen.getImagen();
    int _x = this.getX();
    int _modulo = (_x % 30);
    int _y = this.getY();
    int _modulo_1 = (_y % 30);
    painter.drawTiledPixmap(0, 0, (ancho).intValue(), (alto).intValue(), _imagen_1, _modulo, _modulo_1);
    painter.restore();
  }
}
