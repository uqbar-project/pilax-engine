package org.uqbar.pilax.engine;

import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.uqbar.pilax.engine.PythonUtils;
import org.uqbar.pilax.engine.Tareas;

@SuppressWarnings("all")
public class Tarea {
  private Tareas _planificador;
  
  public Tareas getPlanificador() {
    return this._planificador;
  }
  
  public void setPlanificador(final Tareas planificador) {
    this._planificador = planificador;
  }
  
  private float _time_out;
  
  public float getTime_out() {
    return this._time_out;
  }
  
  public void setTime_out(final float time_out) {
    this._time_out = time_out;
  }
  
  private float _dt;
  
  public float getDt() {
    return this._dt;
  }
  
  public void setDt(final float dt) {
    this._dt = dt;
  }
  
  private Function0<Boolean> _funcion;
  
  public Function0<Boolean> getFuncion() {
    return this._funcion;
  }
  
  public void setFuncion(final Function0<Boolean> funcion) {
    this._funcion = funcion;
  }
  
  private boolean _una_vez;
  
  public boolean isUna_vez() {
    return this._una_vez;
  }
  
  public void setUna_vez(final boolean una_vez) {
    this._una_vez = una_vez;
  }
  
  public Tarea(final Tareas planificador, final float time_out, final float dt, final Function0<Boolean> funcion, final boolean una_vez) {
    Tarea _self = PythonUtils.<Tarea>self(this);
    _self.setPlanificador(planificador);
    Tarea _self_1 = PythonUtils.<Tarea>self(this);
    _self_1.setTime_out(time_out);
    Tarea _self_2 = PythonUtils.<Tarea>self(this);
    _self_2.setDt(dt);
    Tarea _self_3 = PythonUtils.<Tarea>self(this);
    _self_3.setFuncion(funcion);
    Tarea _self_4 = PythonUtils.<Tarea>self(this);
    _self_4.setUna_vez(una_vez);
  }
  
  public Boolean ejecutar() {
    Function0<Boolean> _funcion = this.getFuncion();
    Boolean _apply = _funcion.apply();
    return _apply;
  }
  
  /**
   * "Quita la tarea del planificador para que no se vuelva a ejecutar."
   */
  public boolean eliminar() {
    Tareas _planificador = this.getPlanificador();
    boolean _eliminarTarea = _planificador.eliminarTarea(this);
    return _eliminarTarea;
  }
  
  /**
   * "Termina la tarea (alias de eliminar)."
   */
  public boolean terminar() {
    Tarea _self = PythonUtils.<Tarea>self(this);
    boolean _eliminar = _self.eliminar();
    return _eliminar;
  }
}
