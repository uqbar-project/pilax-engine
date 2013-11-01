package org.uqbar.pilax.engine;

import java.util.List;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure2;
import org.uqbar.pilax.engine.Actor;
import org.uqbar.pilax.engine.PilasExtensions;
import org.uqbar.pilax.engine.PythonUtils;
import org.uqbar.pilax.engine.Utils;

@SuppressWarnings("all")
public class Colision {
  private List<Actor> grupo_a;
  
  private List<Actor> grupo_b;
  
  private Procedure2<Actor,Actor> funcion_a_llamar;
  
  public void verificar() {
    for (final Actor a : this.grupo_a) {
      for (final Actor b : this.grupo_b) {
        try {
          boolean _and = false;
          int _id = PythonUtils.id(a);
          int _id_1 = PythonUtils.id(b);
          boolean _notEquals = (_id != _id_1);
          if (!_notEquals) {
            _and = false;
          } else {
            boolean _colisionan = Utils.colisionan(a, b);
            _and = (_notEquals && _colisionan);
          }
          if (_and) {
            this.funcion_a_llamar.apply(a, b);
          }
          boolean _esActor = PilasExtensions.esActor(a);
          boolean _not = (!_esActor);
          if (_not) {
            boolean _contains = this.grupo_a.contains(a);
            if (_contains) {
              this.grupo_a.remove(a);
            }
          }
          boolean _esActor_1 = PilasExtensions.esActor(b);
          boolean _not_1 = (!_esActor_1);
          if (_not_1) {
            boolean _contains_1 = this.grupo_b.contains(b);
            if (_contains_1) {
              this.grupo_b.remove(b);
            }
          }
        } catch (final Throwable _t) {
          if (_t instanceof RuntimeException) {
            final RuntimeException e = (RuntimeException)_t;
            this.grupo_a.remove(a);
            throw e;
          } else {
            throw Exceptions.sneakyThrow(_t);
          }
        }
      }
    }
  }
}
