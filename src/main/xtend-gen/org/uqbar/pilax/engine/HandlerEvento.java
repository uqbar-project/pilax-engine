package org.uqbar.pilax.engine;

import org.uqbar.pilax.engine.Evento;

@SuppressWarnings("all")
public interface HandlerEvento {
  public abstract void manejar(final Evento e);
}
