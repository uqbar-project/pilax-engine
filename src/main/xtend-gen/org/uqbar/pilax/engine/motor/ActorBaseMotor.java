package org.uqbar.pilax.engine.motor;

import org.eclipse.xtext.xbase.lib.Pair;
import org.uqbar.pilax.engine.PythonUtils;

@SuppressWarnings("all")
public class ActorBaseMotor {
  private int _x;
  
  public int getX() {
    return this._x;
  }
  
  public void setX(final int x) {
    this._x = x;
  }
  
  private int _y;
  
  public int getY() {
    return this._y;
  }
  
  public void setY(final int y) {
    this._y = y;
  }
  
  private int _rotacion = 0;
  
  public int getRotacion() {
    return this._rotacion;
  }
  
  public void setRotacion(final int rotacion) {
    this._rotacion = rotacion;
  }
  
  private int _transparencia = 0;
  
  public int getTransparencia() {
    return this._transparencia;
  }
  
  public void setTransparencia(final int transparencia) {
    this._transparencia = transparencia;
  }
  
  private int _centro_x = 0;
  
  public int getCentro_x() {
    return this._centro_x;
  }
  
  public void setCentro_x(final int centro_x) {
    this._centro_x = centro_x;
  }
  
  private int _centro_y = 0;
  
  public int getCentro_y() {
    return this._centro_y;
  }
  
  public void setCentro_y(final int centro_y) {
    this._centro_y = centro_y;
  }
  
  private int _escala_x = 1;
  
  public int getEscala_x() {
    return this._escala_x;
  }
  
  public void setEscala_x(final int escala_x) {
    this._escala_x = escala_x;
  }
  
  private int _escala_y = 1;
  
  public int getEscala_y() {
    return this._escala_y;
  }
  
  public void setEscala_y(final int escala_y) {
    this._escala_y = escala_y;
  }
  
  private boolean _espejado = false;
  
  public boolean isEspejado() {
    return this._espejado;
  }
  
  public void setEspejado(final boolean espejado) {
    this._espejado = espejado;
  }
  
  private int _fijo = 0;
  
  public int getFijo() {
    return this._fijo;
  }
  
  public void setFijo(final int fijo) {
    this._fijo = fijo;
  }
  
  public ActorBaseMotor(final int x, final int y) {
    this.setX(x);
    this.setY(y);
  }
  
  public void setCentro(final Pair<Integer,Integer> centro) {
    ActorBaseMotor _self = PythonUtils.<ActorBaseMotor>self(this);
    Integer _key = centro.getKey();
    _self.setCentro_x((_key).intValue());
    ActorBaseMotor _self_1 = PythonUtils.<ActorBaseMotor>self(this);
    Integer _value = centro.getValue();
    _self_1.setCentro_y((_value).intValue());
  }
  
  public Pair<Integer,Integer> getCentro() {
    ActorBaseMotor _self = PythonUtils.<ActorBaseMotor>self(this);
    int _centro_x = _self.getCentro_x();
    ActorBaseMotor _self_1 = PythonUtils.<ActorBaseMotor>self(this);
    int _centro_y = _self_1.getCentro_y();
    Pair<Integer,Integer> _mappedTo = Pair.<Integer, Integer>of(Integer.valueOf(_centro_x), Integer.valueOf(_centro_y));
    return _mappedTo;
  }
  
  public Pair<Integer,Integer> getPosicion() {
    ActorBaseMotor _self = PythonUtils.<ActorBaseMotor>self(this);
    int _x = _self.getX();
    ActorBaseMotor _self_1 = PythonUtils.<ActorBaseMotor>self(this);
    int _y = _self_1.getY();
    Pair<Integer,Integer> _mappedTo = Pair.<Integer, Integer>of(Integer.valueOf(_x), Integer.valueOf(_y));
    return _mappedTo;
  }
  
  public void setPosicion(final Pair<Integer,Integer> posicion) {
    ActorBaseMotor _self = PythonUtils.<ActorBaseMotor>self(this);
    Integer _key = posicion.getKey();
    _self.setX((_key).intValue());
    ActorBaseMotor _self_1 = PythonUtils.<ActorBaseMotor>self(this);
    Integer _value = posicion.getValue();
    _self_1.setY((_value).intValue());
  }
  
  public int getEscala() {
    ActorBaseMotor _self = PythonUtils.<ActorBaseMotor>self(this);
    return _self._escala_x;
  }
  
  public int setEscala(final int s) {
    int _xblockexpression = (int) 0;
    {
      ActorBaseMotor _self = PythonUtils.<ActorBaseMotor>self(this);
      _self._escala_x = s;
      ActorBaseMotor _self_1 = PythonUtils.<ActorBaseMotor>self(this);
      int __escala_y = _self_1._escala_y = s;
      _xblockexpression = (__escala_y);
    }
    return _xblockexpression;
  }
}
