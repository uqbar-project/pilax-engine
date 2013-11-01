package org.uqbar.pilax.engine;

import org.uqbar.pilax.engine.EscenaBase;
import org.uqbar.pilax.engine.FondoPlano;

@SuppressWarnings("all")
public class EscenaNormal extends EscenaBase {
  public void iniciar() {
    FondoPlano _fondoPlano = new FondoPlano();
    this.setFondo(_fondoPlano);
  }
}
