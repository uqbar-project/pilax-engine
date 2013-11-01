package org.uqbar.pilax.engine;

import org.uqbar.pilax.engine.Estudiante;

@SuppressWarnings("all")
public abstract class Comportamiento {
  private Estudiante _receptor;
  
  public Estudiante getReceptor() {
    return this._receptor;
  }
  
  public void setReceptor(final Estudiante receptor) {
    this._receptor = receptor;
  }
  
  /**
   * """Se invoca cuando se anexa el comportamiento a un actor.
   * 
   * :param receptor: El actor que comenzará a ejecutar este comportamiento.
   * """
   */
  public void iniciar(final Estudiante receptor) {
    this.setReceptor(receptor);
  }
  
  public abstract void eliminar();
  
  public abstract boolean actualizar();
  
  public Object terminar() {
    return null;
  }
}
