package org.uqbar.pilax.engine;

import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.uqbar.pilax.engine.Colision;

@SuppressWarnings("all")
public class Colisiones {
  private List<Colision> colisiones = new Function0<List<Colision>>() {
    public List<Colision> apply() {
      ArrayList<Colision> _newArrayList = CollectionLiterals.<Colision>newArrayList();
      return _newArrayList;
    }
  }.apply();
  
  public void verificarColisiones() {
    for (final Colision c : this.colisiones) {
      c.verificar();
    }
  }
}
