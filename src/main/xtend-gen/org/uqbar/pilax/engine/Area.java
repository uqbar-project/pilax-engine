package org.uqbar.pilax.engine;

@SuppressWarnings("all")
public class Area {
  private int _izquierda;
  
  public int getIzquierda() {
    return this._izquierda;
  }
  
  public void setIzquierda(final int izquierda) {
    this._izquierda = izquierda;
  }
  
  private int _derecha;
  
  public int getDerecha() {
    return this._derecha;
  }
  
  public void setDerecha(final int derecha) {
    this._derecha = derecha;
  }
  
  private int _arriba;
  
  public int getArriba() {
    return this._arriba;
  }
  
  public void setArriba(final int arriba) {
    this._arriba = arriba;
  }
  
  private int _abajo;
  
  public int getAbajo() {
    return this._abajo;
  }
  
  public void setAbajo(final int abajo) {
    this._abajo = abajo;
  }
  
  public Area(final int izquierda, final int derecha, final int arriba, final int abajo) {
    this.setIzquierda(izquierda);
    this.setDerecha(derecha);
    this.setArriba(arriba);
    this.setAbajo(abajo);
  }
}
