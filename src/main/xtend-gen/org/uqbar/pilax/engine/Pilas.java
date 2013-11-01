package org.uqbar.pilax.engine;

import java.util.List;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.uqbar.pilax.engine.Actor;
import org.uqbar.pilax.engine.EscenaBase;
import org.uqbar.pilax.engine.EscenaNormal;
import org.uqbar.pilax.engine.GestorEscenas;
import org.uqbar.pilax.engine.Motor;
import org.uqbar.pilax.engine.Mundo;

@SuppressWarnings("all")
public class Pilas {
  private static Pilas INSTANCE;
  
  private Mundo _mundoActual;
  
  public Mundo getMundoActual() {
    return this._mundoActual;
  }
  
  public void setMundoActual(final Mundo mundoActual) {
    this._mundoActual = mundoActual;
  }
  
  public static void iniciar() {
    Pilas _pilas = new Pilas();
    Pilas.INSTANCE = _pilas;
    Motor _motor = new Motor();
    final Motor motor = _motor;
    Mundo _mundo = new Mundo(motor, 640, 480);
    Pilas.INSTANCE._mundoActual = _mundo;
    GestorEscenas _gestorEscenas = Pilas.INSTANCE._mundoActual.getGestorEscenas();
    EscenaNormal _escenaNormal = new EscenaNormal();
    _gestorEscenas.cambiarEscena(_escenaNormal);
  }
  
  public static Pilas instance() {
    return Pilas.INSTANCE;
  }
  
  public int ejecutar() {
    Mundo _mundo = this.getMundo();
    int _ejecutarBuclePrincipal = _mundo.ejecutarBuclePrincipal();
    return _ejecutarBuclePrincipal;
  }
  
  public EscenaBase escenaActual() {
    GestorEscenas _gestorEscenas = this._mundoActual.getGestorEscenas();
    EscenaBase _escenaActual = _gestorEscenas.escenaActual();
    return _escenaActual;
  }
  
  public Iterable<Actor> fondos() {
    EscenaBase _escenaActual = this.escenaActual();
    List<Actor> _actores = _escenaActual.getActores();
    final Function1<Actor,Boolean> _function = new Function1<Actor,Boolean>() {
        public Boolean apply(final Actor it) {
          boolean _esFondo = it.esFondo();
          return Boolean.valueOf(_esFondo);
        }
      };
    Iterable<Actor> _filter = IterableExtensions.<Actor>filter(_actores, _function);
    return _filter;
  }
  
  public Mundo getMundo() {
    return this._mundoActual;
  }
  
  public static void main(final String[] args) {
    Pilas.iniciar();
    Pilas _instance = Pilas.instance();
    _instance.ejecutar();
  }
}
