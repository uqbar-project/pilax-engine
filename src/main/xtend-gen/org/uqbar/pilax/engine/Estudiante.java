package org.uqbar.pilax.engine;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.uqbar.pilax.engine.Comportamiento;
import org.uqbar.pilax.engine.Habilidad;
import org.uqbar.pilax.engine.PythonUtils;

@SuppressWarnings("all")
public class Estudiante {
  private List<Habilidad> _habilidades = new Function0<List<Habilidad>>() {
    public List<Habilidad> apply() {
      ArrayList<Habilidad> _newArrayList = CollectionLiterals.<Habilidad>newArrayList();
      return _newArrayList;
    }
  }.apply();
  
  public List<Habilidad> getHabilidades() {
    return this._habilidades;
  }
  
  public void setHabilidades(final List<Habilidad> habilidades) {
    this._habilidades = habilidades;
  }
  
  private List<Comportamiento> _comportamientos = new Function0<List<Comportamiento>>() {
    public List<Comportamiento> apply() {
      ArrayList<Comportamiento> _newArrayList = CollectionLiterals.<Comportamiento>newArrayList();
      return _newArrayList;
    }
  }.apply();
  
  public List<Comportamiento> getComportamientos() {
    return this._comportamientos;
  }
  
  public void setComportamientos(final List<Comportamiento> comportamientos) {
    this._comportamientos = comportamientos;
  }
  
  private Comportamiento _comportamientoActual;
  
  public Comportamiento getComportamientoActual() {
    return this._comportamientoActual;
  }
  
  public void setComportamientoActual(final Comportamiento comportamientoActual) {
    this._comportamientoActual = comportamientoActual;
  }
  
  private boolean repetirComportamientosPorSiempre;
  
  /**
   * """ Elimina una habilidad asociada a un Actor.
   * 
   * :param classname: Referencia a la clase que representa la habilidad.
   * """
   */
  public Boolean eliminar_habilidad(final Class aClass) {
    Boolean _xblockexpression = null;
    {
      Estudiante _self = PythonUtils.<Estudiante>self(this);
      final Habilidad habilidad = _self.obtenerHabilidad(aClass);
      Boolean _xifexpression = null;
      boolean _notEquals = (!Objects.equal(habilidad, null));
      if (_notEquals) {
        Estudiante _self_1 = PythonUtils.<Estudiante>self(this);
        boolean _remove = _self_1._habilidades.remove(habilidad);
        _xifexpression = Boolean.valueOf(_remove);
      }
      _xblockexpression = (_xifexpression);
    }
    return _xblockexpression;
  }
  
  /**
   * """Comprueba si el actor ha aprendido la habilidad indicada.
   * :param classname: Referencia a la clase que representa la habilidad.
   * """
   */
  public boolean tieneHabilidad(final Class aClass) {
    Estudiante _self = PythonUtils.<Estudiante>self(this);
    final Function1<Habilidad,Class<? extends Habilidad>> _function = new Function1<Habilidad,Class<? extends Habilidad>>() {
        public Class<? extends Habilidad> apply(final Habilidad h) {
          Class<? extends Habilidad> _class = h.getClass();
          return _class;
        }
      };
    List<Class<? extends Habilidad>> _map = ListExtensions.<Habilidad, Class<? extends Habilidad>>map(_self._habilidades, _function);
    boolean _contains = _map.contains(aClass);
    return _contains;
  }
  
  /**
   * """Comprueba si el actor tiene el comportamiento indicado.
   * :param classname: Referencia a la clase que representa el comportamiento.
   * """
   */
  public boolean tieneComportamiento(final Class aClass) {
    Estudiante _self = PythonUtils.<Estudiante>self(this);
    List<Comportamiento> _comportamientos = _self.getComportamientos();
    final Function1<Comportamiento,Class<? extends Comportamiento>> _function = new Function1<Comportamiento,Class<? extends Comportamiento>>() {
        public Class<? extends Comportamiento> apply(final Comportamiento h) {
          Class<? extends Comportamiento> _class = h.getClass();
          return _class;
        }
      };
    List<Class<? extends Comportamiento>> _map = ListExtensions.<Comportamiento, Class<? extends Comportamiento>>map(_comportamientos, _function);
    boolean _contains = _map.contains(aClass);
    return _contains;
  }
  
  /**
   * """Obtiene la habilidad asociada a un Actor.
   * 
   * :param classname: Referencia a la clase que representa la habilidad.
   * :return: Devuelve None si no se encontró.
   * """
   */
  public Habilidad obtenerHabilidad(final Class classname) {
    Estudiante _self = PythonUtils.<Estudiante>self(this);
    for (final Habilidad habilidad : _self._habilidades) {
      Class<? extends Habilidad> _class = habilidad.getClass();
      boolean _equals = Objects.equal(_class, classname);
      if (_equals) {
        return habilidad;
      }
    }
    return PythonUtils.<Habilidad>None(this);
  }
  
  /**
   * Define un nuevo comportamiento para realizar al final.
   * Los actores pueden tener una cadena de comportamientos, este
   * metodo agrega el comportamiento al final de la cadena.
   * :param comportamiento: Referencia al comportamiento.
   * :param repetir_por_siempre: Si el comportamiento se volverá a ejecutar luego de terminar.
   * """
   */
  public boolean hacerLuego(final Comportamiento comportamiento, final boolean repetir_por_siempre) {
    boolean _xblockexpression = false;
    {
      Estudiante _self = PythonUtils.<Estudiante>self(this);
      List<Comportamiento> _comportamientos = _self.getComportamientos();
      _comportamientos.add(comportamiento);
      Estudiante _self_1 = PythonUtils.<Estudiante>self(this);
      boolean _repetirComportamientosPorSiempre = _self_1.repetirComportamientosPorSiempre = repetir_por_siempre;
      _xblockexpression = (_repetirComportamientosPorSiempre);
    }
    return _xblockexpression;
  }
  
  /**
   * Define el comportamiento para el actor de manera inmediata.
   * :param comportamiento: Referencia al comportamiento a realizar.
   */
  public void hacer(final Comportamiento comportamiento) {
    Estudiante _self = PythonUtils.<Estudiante>self(this);
    List<Comportamiento> _comportamientos = _self.getComportamientos();
    _comportamientos.add(comportamiento);
    Estudiante _self_1 = PythonUtils.<Estudiante>self(this);
    _self_1.adoptarElSiguienteComportamiento();
  }
  
  /**
   * "Elimina todas las habilidades asociadas al actor."
   */
  public void eliminarHabilidades() {
    Estudiante _self = PythonUtils.<Estudiante>self(this);
    final Procedure1<Habilidad> _function = new Procedure1<Habilidad>() {
        public void apply(final Habilidad it) {
          it.eliminar();
        }
      };
    IterableExtensions.<Habilidad>forEach(_self._habilidades, _function);
  }
  
  /**
   * "Elimina todos los comportamientos que tiene que hacer el actor."
   */
  public void eliminarComportamientos() {
    Estudiante _self = PythonUtils.<Estudiante>self(this);
    List<Comportamiento> _comportamientos = _self.getComportamientos();
    final Procedure1<Comportamiento> _function = new Procedure1<Comportamiento>() {
        public void apply(final Comportamiento it) {
          it.eliminar();
        }
      };
    IterableExtensions.<Comportamiento>forEach(_comportamientos, _function);
  }
  
  public void actualizarHabilidades() {
    Estudiante _self = PythonUtils.<Estudiante>self(this);
    final Procedure1<Habilidad> _function = new Procedure1<Habilidad>() {
        public void apply(final Habilidad it) {
          it.actualizar();
        }
      };
    IterableExtensions.<Habilidad>forEach(_self._habilidades, _function);
  }
  
  /**
   * "Actualiza la lista de comportamientos"
   */
  public void actualizarComportamientos() {
    boolean termina = false;
    Estudiante _self = PythonUtils.<Estudiante>self(this);
    Comportamiento _comportamientoActual = _self.getComportamientoActual();
    boolean _notEquals = (!Objects.equal(_comportamientoActual, null));
    if (_notEquals) {
      Estudiante _self_1 = PythonUtils.<Estudiante>self(this);
      Comportamiento _comportamientoActual_1 = _self_1.getComportamientoActual();
      boolean _actualizar = _comportamientoActual_1.actualizar();
      termina = _actualizar;
      if (termina) {
        Estudiante _self_2 = PythonUtils.<Estudiante>self(this);
        if (_self_2.repetirComportamientosPorSiempre) {
          Estudiante _self_3 = PythonUtils.<Estudiante>self(this);
          List<Comportamiento> _comportamientos = _self_3.getComportamientos();
          Estudiante _self_4 = PythonUtils.<Estudiante>self(this);
          Comportamiento _comportamientoActual_2 = _self_4.getComportamientoActual();
          _comportamientos.add(_comportamientoActual_2);
        }
        Estudiante _self_5 = PythonUtils.<Estudiante>self(this);
        _self_5.adoptarElSiguienteComportamiento();
      }
    } else {
      Estudiante _self_6 = PythonUtils.<Estudiante>self(this);
      _self_6.adoptarElSiguienteComportamiento();
    }
  }
  
  public void adoptarElSiguienteComportamiento() {
    List<Comportamiento> _comportamientos = this.getComportamientos();
    boolean _notEquals = (!Objects.equal(_comportamientos, null));
    if (_notEquals) {
      List<Comportamiento> _comportamientos_1 = this.getComportamientos();
      Comportamiento _pop = PythonUtils.<Comportamiento>pop(_comportamientos_1, 0);
      this.setComportamientoActual(_pop);
      Comportamiento _comportamientoActual = this.getComportamientoActual();
      Estudiante _self = PythonUtils.<Estudiante>self(this);
      _comportamientoActual.iniciar(_self);
    } else {
      Comportamiento _None = PythonUtils.<Comportamiento>None(this);
      this.setComportamientoActual(_None);
    }
  }
}
