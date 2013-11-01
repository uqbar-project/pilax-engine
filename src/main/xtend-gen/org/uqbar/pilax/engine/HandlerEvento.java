package org.uqbar.pilax.engine;

import org.uqbar.pilax.engine.DataEvento;

@SuppressWarnings("all")
public interface HandlerEvento<D extends DataEvento> {
  public abstract void manejar(final D data);
}
