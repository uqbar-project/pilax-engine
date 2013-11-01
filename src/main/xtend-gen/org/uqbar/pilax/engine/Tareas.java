package org.uqbar.pilax.engine;

import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.eclipse.xtext.xbase.lib.IntegerRange;
import org.uqbar.pilax.engine.PythonUtils;
import org.uqbar.pilax.engine.Tarea;
import org.uqbar.pilax.engine.TareaCondicional;

@SuppressWarnings("all")
public class Tareas {
  private List<Tarea> tareas_planificadas = new Function0<List<Tarea>>() {
    public List<Tarea> apply() {
      ArrayList<Tarea> _newArrayList = CollectionLiterals.<Tarea>newArrayList();
      return _newArrayList;
    }
  }.apply();
  
  private float contador_de_tiempo = 0f;
  
  public int obtener_cantidad_de_tareas_planificadas() {
    Tareas _self = PythonUtils.<Tareas>self(this);
    return _self.tareas_planificadas.size();
  }
  
  /**
   * Agrega una nueva tarea para ejecutarse luego.
   * :param tarea: Referencia a la tarea que se debe agregar.
   */
  public boolean agregar(final Tarea tarea) {
    Tareas _self = PythonUtils.<Tareas>self(this);
    boolean _add = _self.tareas_planificadas.add(tarea);
    return _add;
  }
  
  /**
   * """Elimina una tarea de la lista de tareas planificadas.
   * :param tarea: Referencia a la tarea que se tiene que eliminar.
   * """
   */
  public boolean eliminarTarea(final Tarea tarea) {
    Tareas _self = PythonUtils.<Tareas>self(this);
    boolean _remove = _self.tareas_planificadas.remove(tarea);
    return _remove;
  }
  
  /**
   * Actualiza los contadores de tiempo y ejecuta las tareas pendientes.
   * 
   * :param dt: Tiempo transcurrido desde la anterior llamada.
   */
  public void actualizar(final float dt) {
    Tareas _self = PythonUtils.<Tareas>self(this);
    Tareas _self_1 = PythonUtils.<Tareas>self(this);
    float _plus = (_self_1.contador_de_tiempo + dt);
    _self.contador_de_tiempo = _plus;
    final ArrayList<Tarea> tareas_a_eliminar = CollectionLiterals.<Tarea>newArrayList();
    Tareas _self_2 = PythonUtils.<Tareas>self(this);
    for (final Tarea tarea : _self_2.tareas_planificadas) {
      Tareas _self_3 = PythonUtils.<Tareas>self(this);
      float _time_out = tarea.getTime_out();
      boolean _greaterThan = (_self_3.contador_de_tiempo > _time_out);
      if (_greaterThan) {
        tarea.ejecutar();
        boolean _isUna_vez = tarea.isUna_vez();
        if (_isUna_vez) {
          tareas_a_eliminar.add(tarea);
        } else {
          Tareas _self_4 = PythonUtils.<Tareas>self(this);
          float _time_out_1 = tarea.getTime_out();
          final float w = (_self_4.contador_de_tiempo - _time_out_1);
          float _dt = tarea.getDt();
          float _floatValue = Float.valueOf(_dt).floatValue();
          float _divide = (w / _floatValue);
          final int parte_entera = Float.valueOf(_divide).intValue();
          float _dt_1 = tarea.getDt();
          float _multiply = (parte_entera * _dt_1);
          final float resto = (w - _multiply);
          IntegerRange _range = PythonUtils.range(parte_entera);
          for (final Integer x : _range) {
            tarea.ejecutar();
          }
          float _time_out_2 = tarea.getTime_out();
          float _dt_2 = tarea.getDt();
          float _plus_1 = (_time_out_2 + _dt_2);
          float _dt_3 = tarea.getDt();
          float _multiply_1 = (parte_entera * _dt_3);
          float _plus_2 = (_plus_1 + _multiply_1);
          float _minus = (_plus_2 - resto);
          tarea.setTime_out(_minus);
        }
      }
    }
    for (final Tarea x_1 : tareas_a_eliminar) {
      Tareas _self_5 = PythonUtils.<Tareas>self(this);
      boolean _contains = _self_5.tareas_planificadas.contains(x_1);
      if (_contains) {
        Tareas _self_6 = PythonUtils.<Tareas>self(this);
        _self_6.tareas_planificadas.remove(x_1);
      }
    }
  }
  
  public Tarea unaVez(final int time_out, final Function0<Boolean> function) {
    Tarea _xblockexpression = null;
    {
      Tareas _self = PythonUtils.<Tareas>self(this);
      Tareas _self_1 = PythonUtils.<Tareas>self(this);
      float _plus = (_self_1.contador_de_tiempo + time_out);
      Tarea _tarea = new Tarea(_self, _plus, time_out, function, true);
      final Tarea tarea = _tarea;
      Tareas _self_2 = PythonUtils.<Tareas>self(this);
      _self_2.agregar(tarea);
      _xblockexpression = (tarea);
    }
    return _xblockexpression;
  }
  
  public Tarea siempre(final int time_out, final Function0<Boolean> function) {
    Tarea _xblockexpression = null;
    {
      Tareas _self = PythonUtils.<Tareas>self(this);
      Tareas _self_1 = PythonUtils.<Tareas>self(this);
      float _plus = (_self_1.contador_de_tiempo + time_out);
      Tarea _tarea = new Tarea(_self, _plus, time_out, function, false);
      final Tarea tarea = _tarea;
      Tareas _self_2 = PythonUtils.<Tareas>self(this);
      _self_2.agregar(tarea);
      _xblockexpression = (tarea);
    }
    return _xblockexpression;
  }
  
  public TareaCondicional condicional(final int time_out, final Function0<Boolean> function) {
    TareaCondicional _xblockexpression = null;
    {
      Tareas _self = PythonUtils.<Tareas>self(this);
      Tareas _self_1 = PythonUtils.<Tareas>self(this);
      float _plus = (_self_1.contador_de_tiempo + time_out);
      TareaCondicional _tareaCondicional = new TareaCondicional(_self, _plus, time_out, function, false);
      final TareaCondicional tarea = _tareaCondicional;
      Tareas _self_2 = PythonUtils.<Tareas>self(this);
      _self_2.agregar(tarea);
      _xblockexpression = (tarea);
    }
    return _xblockexpression;
  }
  
  /**
   * Elimina una tarea de la lista de tareas planificadas.
   * 
   * :param tarea: Referencia a la tarea que se tiene que eliminar.
   */
  public boolean eliminar_tarea(final Tarea tarea) {
    Tareas _self = PythonUtils.<Tareas>self(this);
    boolean _remove = _self.tareas_planificadas.remove(tarea);
    return _remove;
  }
  
  /**
   * Elimina todas las tareas de la lista de planificadas.
   */
  public List<Tarea> eliminar_todas() {
    Tareas _self = PythonUtils.<Tareas>self(this);
    ArrayList<Tarea> _newArrayList = CollectionLiterals.<Tarea>newArrayList();
    List<Tarea> _tareas_planificadas = _self.tareas_planificadas = _newArrayList;
    return _tareas_planificadas;
  }
}
