package org.uqbar.pilax.engine;

import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.uqbar.pilax.engine.PythonUtils;
import org.uqbar.pilax.engine.Tarea;
import org.uqbar.pilax.engine.Tareas;

@SuppressWarnings("all")
public class TareaCondicional extends Tarea {
  public TareaCondicional(final Tareas planificador, final float time_out, final float dt, final Function0<Boolean> funcion, final boolean una_vez) {
    super(planificador, time_out, dt, funcion, una_vez);
  }
  
  /**
   * """Ejecuta la tarea, y se detiene si no revuelve True."""
   */
  public Boolean ejecutar() {
    Boolean _xblockexpression = null;
    {
      final Boolean retorno = super.ejecutar();
      boolean _not = (!(retorno).booleanValue());
      if (_not) {
        TareaCondicional _self = PythonUtils.<TareaCondicional>self(this);
        _self.setUna_vez(true);
      }
      _xblockexpression = (retorno);
    }
    return _xblockexpression;
  }
}
