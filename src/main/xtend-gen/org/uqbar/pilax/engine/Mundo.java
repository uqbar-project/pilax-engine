package org.uqbar.pilax.engine;

import org.eclipse.xtext.xbase.lib.Pair;
import org.uqbar.pilax.engine.Fisica;
import org.uqbar.pilax.engine.FisicaDeshabilitada;
import org.uqbar.pilax.engine.GestorEscenas;
import org.uqbar.pilax.engine.Motor;

@SuppressWarnings("all")
public class Mundo {
  private GestorEscenas _gestorEscenas;
  
  public GestorEscenas getGestorEscenas() {
    return this._gestorEscenas;
  }
  
  public void setGestorEscenas(final GestorEscenas gestorEscenas) {
    this._gestorEscenas = gestorEscenas;
  }
  
  private Motor _motor;
  
  public Motor getMotor() {
    return this._motor;
  }
  
  public void setMotor(final Motor motor) {
    this._motor = motor;
  }
  
  private Pair<Integer,Integer> gravedad;
  
  public Mundo(final Motor motor, final int ancho, final int alto) {
    this.setMotor(motor);
    GestorEscenas _gestorEscenas = new GestorEscenas();
    this.setGestorEscenas(_gestorEscenas);
    Motor _motor = this.getMotor();
    GestorEscenas _gestorEscenas_1 = this.getGestorEscenas();
    _motor.iniciarVentana(ancho, alto, "PilaX (Pilas Engine en XTend)", false, _gestorEscenas_1, 60);
    int _minus = (-10);
    Pair<Integer,Integer> _mappedTo = Pair.<Integer, Integer>of(Integer.valueOf(0), Integer.valueOf(_minus));
    this.gravedad = _mappedTo;
  }
  
  public int ejecutarBuclePrincipal() {
    Motor _motor = this.getMotor();
    int _ejecutarBuclePrincipal = _motor.ejecutarBuclePrincipal(this);
    return _ejecutarBuclePrincipal;
  }
  
  public FisicaDeshabilitada crearMotorFisica() {
    Motor _motor = this.getMotor();
    Pair<Integer,Integer> _area = _motor.getArea();
    return Fisica.crearMotorFisica(_area, this.gravedad);
  }
}
