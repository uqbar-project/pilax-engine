package org.uqbar.pilax.engine;

import org.eclipse.xtext.xbase.lib.Pair;
import org.uqbar.pilax.engine.Actor;
import org.uqbar.pilax.engine.Area;

@SuppressWarnings("all")
public class Utils {
  public static Pair<Float,Float> convertirDePosicionFisicaRelativa(final float x, final float y) {
    UnsupportedOperationException _unsupportedOperationException = new UnsupportedOperationException("TODO: auto-generated method stub");
    throw _unsupportedOperationException;
  }
  
  public static Area obtenerBordes() {
    UnsupportedOperationException _unsupportedOperationException = new UnsupportedOperationException("TODO: auto-generated method stub");
    throw _unsupportedOperationException;
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
