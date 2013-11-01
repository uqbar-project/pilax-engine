package org.uqbar.pilax.engine;

import org.eclipse.xtext.xbase.lib.InputOutput;
import org.eclipse.xtext.xbase.lib.Pair;
import org.uqbar.pilax.engine.FisicaDeshabilitada;

@SuppressWarnings("all")
public class Fisica {
  /**
   * """Genera el motor de física Box2D.
   * 
   * :param area: El area de juego.
   * :param gravedad: La gravedad del escenario.
   * """
   */
  public static FisicaDeshabilitada crearMotorFisica(final Pair<Integer,Integer> area, final Pair<Integer,Integer> gravedad) {
    InputOutput.<String>print("No se pudo iniciar Box2D, se deshabilita el soporte de Fisica.");
    FisicaDeshabilitada _fisicaDeshabilitada = new FisicaDeshabilitada(area, gravedad);
    return _fisicaDeshabilitada;
  }
}
