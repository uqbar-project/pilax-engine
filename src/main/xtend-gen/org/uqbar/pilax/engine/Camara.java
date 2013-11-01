package org.uqbar.pilax.engine;

import org.eclipse.xtext.xbase.lib.Pair;
import org.uqbar.pilax.engine.Area;
import org.uqbar.pilax.engine.EscenaBase;
import org.uqbar.pilax.engine.Evento;
import org.uqbar.pilax.engine.Motor;
import org.uqbar.pilax.engine.Mundo;
import org.uqbar.pilax.engine.Pilas;
import org.uqbar.pilax.engine.PythonUtils;

@SuppressWarnings("all")
public class Camara {
  private EscenaBase escena;
  
  public Camara(final EscenaBase escena) {
    this.escena = escena;
  }
  
  /**
   * Retorna el area del escenario que está visible por la cámara.
   * 
   * Por ejemplo, si la cámara está en posición inicial, esta
   * función podría retornar:
   * 
   * >>> pilas.escena_actual().camara.obtener_area_visible()
   * (0, 640, 240, -240)
   * 
   * y si movemos la cámara un poco para la derecha:
   * 
   * >>> pilas.escena_actual().camara.x = 100
   * >>> pilas.escena_actual().camara.obtener_area_visible()
   * (100, 740, 240, -240)
   * 
   * Es decir, la tupla representa un rectángulo de la forma::
   * 
   * (izquierda, derecha, arriba, abajo)
   * 
   * En nuestro caso, el último ejemplo muestra que cuando
   * la cámara se mueve a ``x = 100`` el area de pantalla
   * visible es ``(izquierda=100, derecha=740, arriba=240, abajo=-240)``.
   * ¡ ha quedado invisible todo lo que está a la izquierda de ``x=100`` !
   * 
   * Esta función es útil para ``despetar`` actores o simplemente
   * 
   * 
   * Si quieres saber si un actor está fuera de la pantalla hay un
   * atajo, existe un método llamado ``esta_fuera_de_la_pantalla`` en
   * los propios actores:
   * 
   * >>> mi_actor = pilas.actores.Mono(x=0, y=0)
   * >>> mi_actor.esta_fuera_de_la_pantalla()
   * False
   * >>> pilas.escena_actual().camara.x == 900
   * >>> mi_actor.esta_fuera_de_la_pantalla()
   * True
   */
  public Area getAreaVisible() {
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    Motor _motor = _mundo.getMotor();
    final Pair<Integer,Integer> areaMotor = _motor.getArea();
    final Integer ancho = areaMotor.getKey();
    final Integer alto = areaMotor.getValue();
    Camara _self = PythonUtils.<Camara>self(this);
    Integer _x = _self.getX();
    int _divide = ((ancho).intValue() / 2);
    int _minus = ((_x).intValue() - _divide);
    Camara _self_1 = PythonUtils.<Camara>self(this);
    Integer _x_1 = _self_1.getX();
    int _divide_1 = ((ancho).intValue() / 2);
    int _plus = ((_x_1).intValue() + _divide_1);
    Camara _self_2 = PythonUtils.<Camara>self(this);
    Integer _y = _self_2.getY();
    int _divide_2 = ((alto).intValue() / 2);
    int _plus_1 = ((_y).intValue() + _divide_2);
    Camara _self_3 = PythonUtils.<Camara>self(this);
    Integer _y_1 = _self_3.getY();
    int _divide_3 = ((alto).intValue() / 2);
    int _minus_1 = ((_y_1).intValue() - _divide_3);
    Area _area = new Area(_minus, _plus, _plus_1, _minus_1);
    return _area;
  }
  
  public void setX(final int x) {
    Pilas _instance = Pilas.instance();
    EscenaBase _escenaActual = _instance.escenaActual();
    Evento _mueveCamara = _escenaActual.getMueveCamara();
    Camara _self = PythonUtils.<Camara>self(this);
    Integer _y = _self.getY();
    Camara _self_1 = PythonUtils.<Camara>self(this);
    Integer _x = _self_1.getX();
    int _minus = (x - (_x).intValue());
    _mueveCamara.emitir(x, (_y).intValue(), _minus, 0);
    Pilas _instance_1 = Pilas.instance();
    Mundo _mundo = _instance_1.getMundo();
    Motor _motor = _mundo.getMotor();
    Camara _self_2 = PythonUtils.<Camara>self(this);
    Integer _y_1 = _self_2.getY();
    Pair<Integer,Integer> _mappedTo = Pair.<Integer, Integer>of(Integer.valueOf(x), _y_1);
    _motor.setCentroDeLaCamara(_mappedTo);
  }
  
  public Integer getX() {
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    Motor _motor = _mundo.getMotor();
    Pair<Integer,Integer> _centroDeLaCamara = _motor.getCentroDeLaCamara();
    Integer _key = _centroDeLaCamara.getKey();
    return _key;
  }
  
  /**
   * Define la posición vertical de la cámara.
   * 
   * :param y: Posición vertical.
   */
  public void setY(final int y) {
    Pilas _instance = Pilas.instance();
    EscenaBase _escenaActual = _instance.escenaActual();
    Evento _mueveCamara = _escenaActual.getMueveCamara();
    Camara _self = PythonUtils.<Camara>self(this);
    Integer _x = _self.getX();
    Camara _self_1 = PythonUtils.<Camara>self(this);
    Integer _y = _self_1.getY();
    int _minus = (y - (_y).intValue());
    _mueveCamara.emitir((_x).intValue(), y, 0, _minus);
    Pilas _instance_1 = Pilas.instance();
    Mundo _mundo = _instance_1.getMundo();
    Motor _motor = _mundo.getMotor();
    Camara _self_2 = PythonUtils.<Camara>self(this);
    Integer _x_1 = _self_2.getX();
    Pair<Integer,Integer> _mappedTo = Pair.<Integer, Integer>of(_x_1, Integer.valueOf(y));
    _motor.setCentroDeLaCamara(_mappedTo);
  }
  
  public Integer getY() {
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    Motor _motor = _mundo.getMotor();
    Pair<Integer,Integer> _centroDeLaCamara = _motor.getCentroDeLaCamara();
    Integer _value = _centroDeLaCamara.getValue();
    return _value;
  }
}
