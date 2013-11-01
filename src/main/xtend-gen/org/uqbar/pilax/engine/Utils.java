package org.uqbar.pilax.engine;

import org.eclipse.xtext.xbase.lib.Pair;
import org.uqbar.pilax.engine.Actor;
import org.uqbar.pilax.engine.Area;
import org.uqbar.pilax.engine.Motor;
import org.uqbar.pilax.engine.Mundo;
import org.uqbar.pilax.engine.Pilas;

@SuppressWarnings("all")
public class Utils {
  public static Pair<Float,Float> convertirDePosicionFisicaRelativa(final float x, final float y) {
    Pair<Float,Float> _xblockexpression = null;
    {
      Pilas _instance = Pilas.instance();
      Mundo _mundo = _instance.getMundo();
      Motor _motor = _mundo.getMotor();
      final Pair<Integer,Integer> centroFisico = _motor.centroFisico();
      final Integer dx = centroFisico.getKey();
      final Integer dy = centroFisico.getValue();
      float _minus = (x - (dx).intValue());
      float _minus_1 = ((dy).intValue() - y);
      Pair<Float,Float> _mappedTo = Pair.<Float, Float>of(Float.valueOf(_minus), Float.valueOf(_minus_1));
      _xblockexpression = (_mappedTo);
    }
    return _xblockexpression;
  }
  
  public static Area obtenerBordes() {
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    Motor _motor = _mundo.getMotor();
    final Pair<Integer,Integer> area = _motor.getArea();
    final Integer ancho = area.getKey();
    final Integer alto = area.getValue();
    int _minus = (-(ancho).intValue());
    int _divide = (_minus / 2);
    int _divide_1 = ((ancho).intValue() / 2);
    int _divide_2 = ((alto).intValue() / 2);
    int _minus_1 = (-(alto).intValue());
    int _divide_3 = (_minus_1 / 2);
    Area _area = new Area(_divide, _divide_1, _divide_2, _divide_3);
    return _area;
  }
  
  public static boolean colisionan(final Actor a, final Actor b) {
    double _distanciaEntreDosActores = Utils.distanciaEntreDosActores(a, b);
    int _radioDeColision = a.getRadioDeColision();
    int _radioDeColision_1 = b.getRadioDeColision();
    int _plus = (_radioDeColision + _radioDeColision_1);
    boolean _lessThan = (_distanciaEntreDosActores < _plus);
    return _lessThan;
  }
  
  public static double distanciaEntreDosActores(final Actor a, final Actor b) {
    int _x = a.getX();
    int _y = a.getY();
    Pair<Integer,Integer> _mappedTo = Pair.<Integer, Integer>of(Integer.valueOf(_x), Integer.valueOf(_y));
    int _x_1 = b.getX();
    int _y_1 = b.getY();
    Pair<Integer,Integer> _mappedTo_1 = Pair.<Integer, Integer>of(Integer.valueOf(_x_1), Integer.valueOf(_y_1));
    double _distanciaEntreDosPuntos = Utils.distanciaEntreDosPuntos(_mappedTo, _mappedTo_1);
    return _distanciaEntreDosPuntos;
  }
  
  public static double distanciaEntreDosPuntos(final Pair<Integer,Integer> pair, final Pair<Integer,Integer> pair2) {
    double _xblockexpression = (double) 0;
    {
      final Integer x1 = pair.getKey();
      final Integer y1 = pair.getValue();
      final Integer x2 = pair2.getKey();
      final Integer y2 = pair2.getValue();
      int _distancia = Utils.distancia(x1, x2);
      double _power = Math.pow(_distancia, 2);
      int _distancia_1 = Utils.distancia(y1, y2);
      double _power_1 = Math.pow(_distancia_1, 2);
      double _plus = (_power + _power_1);
      double _sqrt = Math.sqrt(_plus);
      _xblockexpression = (_sqrt);
    }
    return _xblockexpression;
  }
  
  public static int distancia(final Integer a, final Integer b) {
    int _minus = ((b).intValue() - (a).intValue());
    int _abs = Math.abs(_minus);
    return _abs;
  }
}
