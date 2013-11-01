package org.uqbar.pilax.engine;

import java.util.List;
import org.eclipse.xtext.xbase.lib.Pair;
import org.uqbar.pilax.engine.Actor;
import org.uqbar.pilax.engine.EscenaBase;
import org.uqbar.pilax.engine.Motor;
import org.uqbar.pilax.engine.Mundo;
import org.uqbar.pilax.engine.Pilas;

@SuppressWarnings("all")
public class PilasExtensions {
  public static boolean esActor(final Object obj) {
    Pilas _instance = Pilas.instance();
    EscenaBase _escenaActual = _instance.escenaActual();
    List<Actor> _actores = _escenaActual.getActores();
    boolean _contains = _actores.contains(obj);
    return _contains;
  }
  
  public static EscenaBase eventos(final Object obj) {
    Pilas _instance = Pilas.instance();
    EscenaBase _escenaActual = _instance.escenaActual();
    return _escenaActual;
  }
  
  public static Pair<Float,Float> relativaALaCamara(final Pair<Float,Float> coordenada) {
    Float _key = coordenada.getKey();
    int _camaraX = PilasExtensions.camaraX();
    float _plus = ((_key).floatValue() + _camaraX);
    Float _value = coordenada.getValue();
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    Motor _motor = _mundo.getMotor();
    int _camaraY = _motor.getCamaraY();
    float _plus_1 = ((_value).floatValue() + _camaraY);
    Pair<Float,Float> _mappedTo = Pair.<Float, Float>of(Float.valueOf(_plus), Float.valueOf(_plus_1));
    return _mappedTo;
  }
  
  public static int camaraX() {
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    Motor _motor = _mundo.getMotor();
    int _camaraX = _motor.getCamaraX();
    return _camaraX;
  }
  
  public static int camaraY() {
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    Motor _motor = _mundo.getMotor();
    int _camaraY = _motor.getCamaraY();
    return _camaraY;
  }
}
