package org.uqbar.pilax.engine;

import com.trolltech.qt.gui.QPainter;
import org.uqbar.pilax.engine.Actor;
import org.uqbar.pilax.engine.Motor;

@SuppressWarnings("all")
public class DepuradorDeshabilitado {
  public Object comienza_dibujado(final Motor motor, final QPainter painter) {
    return null;
  }
  
  public Object dibuja_al_actor(final Motor motor, final QPainter painter, final Actor actor) {
    return null;
  }
  
  public Object termina_dibujado(final Motor motor, final QPainter painter) {
    return null;
  }
  
  public Object cuando_pulsa_tecla(final Object codigo_tecla, final Object texto_tecla) {
    return null;
  }
  
  public Object cuando_mueve_el_mouse(final int x, final int y) {
    return null;
  }
}
