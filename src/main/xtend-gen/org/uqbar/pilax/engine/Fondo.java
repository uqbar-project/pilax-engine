package org.uqbar.pilax.engine;

import com.google.common.base.Objects;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.uqbar.pilax.engine.Actor;
import org.uqbar.pilax.engine.Pilas;
import org.uqbar.pilax.engine.PilasExtensions;

@SuppressWarnings("all")
public class Fondo extends Actor {
  public Fondo(final String imagen) {
    super(imagen, 0, 0);
    this.eliminarFondosAnteriores();
    this.setZ(1000);
  }
  
  public boolean esFondo() {
    return true;
  }
  
  protected void eliminarFondosAnteriores() {
    Pilas _instance = Pilas.instance();
    Iterable<Actor> _fondos = _instance.fondos();
    Iterable<Actor> _copy = PilasExtensions.<Actor>copy(_fondos);
    final Procedure1<Actor> _function = new Procedure1<Actor>() {
        public void apply(final Actor it) {
          boolean _notEquals = (!Objects.equal(it, Fondo.this));
          if (_notEquals) {
            it.eliminar();
          }
        }
      };
    IterableExtensions.<Actor>forEach(_copy, _function);
  }
}
