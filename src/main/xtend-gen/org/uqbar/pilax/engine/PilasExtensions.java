package org.uqbar.pilax.engine;

import java.util.List;
import org.uqbar.pilax.engine.Actor;
import org.uqbar.pilax.engine.EscenaBase;
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
}
