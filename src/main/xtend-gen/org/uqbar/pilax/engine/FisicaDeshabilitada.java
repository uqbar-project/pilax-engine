package org.uqbar.pilax.engine;

import org.eclipse.xtext.xbase.lib.Pair;
import org.uqbar.pilax.engine.Motor;

@SuppressWarnings("all")
public class FisicaDeshabilitada {
  public FisicaDeshabilitada(final Pair<Integer,Integer> area, final Pair<Integer,Integer> gravedad) {
  }
  
  public Object actualizar() {
    return null;
  }
  
  public Object dibujar_figuras_sobre_lienzo(final Motor motor, final Object lienzo, final int grosor) {
    return null;
  }
  
  public Object crear_bordes_del_escenario() {
    return null;
  }
  
  public Object reiniciar() {
    return null;
  }
  
  public Object capturar_figura_con_el_mouse(final Object figura) {
    return null;
  }
  
  public Object cuando_mueve_el_mouse(final int x, final int y) {
    return null;
  }
  
  public Object cuando_suelta_el_mouse() {
    return null;
  }
  
  public Object pausar_mundo() {
    return null;
  }
  
  public Object reanudar_mundo() {
    return null;
  }
  
  public Object crear_cuerpo(final Object definicion_de_cuerpo) {
    return null;
  }
  
  public Object crear_suelo(final int ancho, final int alto, final int restitucion) {
    return null;
  }
  
  public Object crear_techo(final int ancho, final int alto, final int restitucion) {
    return null;
  }
  
  public Object crear_paredes(final int ancho, final int alto, final int restitucion) {
    return null;
  }
  
  public Object eliminar_suelo() {
    return null;
  }
  
  public Object eliminar_techo() {
    return null;
  }
  
  public Object eliminar_paredes() {
    return null;
  }
  
  public Object obtener_distancia_al_suelo(final int x, final int y, final int dy) {
    return null;
  }
  
  public Object eliminar_figura(final Object figura) {
    return null;
  }
  
  public Object obtener_cuerpos_en(final int x, final int y) {
    return null;
  }
  
  public Object definir_gravedad(final int x, final int y) {
    return null;
  }
}
