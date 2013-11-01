package org.uqbar.pilax.engine;

import java.util.ArrayList;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.uqbar.pilax.engine.Actor;
import org.uqbar.pilax.engine.Pilas;

@SuppressWarnings("all")
public class Fondo extends Actor {
  public Fondo(final String imagen) {
    super(imagen, 0, 0);
    this.eliminarFondoActual();
    this.setZ(1000);
  }
  
  public boolean esFondo() {
    return true;
  }
  
  protected void eliminarFondoActual() {
    final ArrayList<Actor> aEliminar = CollectionLiterals.<Actor>newArrayList();
    Pilas _instance = Pilas.instance();
    Iterable<Actor> _fondos = _instance.fondos();
    for (final Actor f : _fondos) {
      aEliminar.add(f);
    }
    for (final Actor fondo : aEliminar) {
      fondo.eliminar();
    }
  }
}
