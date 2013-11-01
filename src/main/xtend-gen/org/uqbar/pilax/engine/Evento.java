package org.uqbar.pilax.engine;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.uqbar.pilax.engine.DataEvento;
import org.uqbar.pilax.engine.HandlerEvento;

@SuppressWarnings("all")
public class Evento {
  private Map<String,HandlerEvento> _respuestas;
  
  public Map<String,HandlerEvento> getRespuestas() {
    return this._respuestas;
  }
  
  public void setRespuestas(final Map<String,HandlerEvento> respuestas) {
    this._respuestas = respuestas;
  }
  
  private String _nombre;
  
  public String getNombre() {
    return this._nombre;
  }
  
  public void setNombre(final String nombre) {
    this._nombre = nombre;
  }
  
  public Evento(final String nombre) {
    this.setNombre(nombre);
    HashMap<String,HandlerEvento> _newHashMap = CollectionLiterals.<String, HandlerEvento>newHashMap();
    this.setRespuestas(_newHashMap);
  }
  
  public void emitir(final DataEvento data) {
    final ArrayList<HandlerEvento> a_eliminar = CollectionLiterals.<HandlerEvento>newArrayList();
    Map<String,HandlerEvento> _respuestas = this.getRespuestas();
    Collection<HandlerEvento> _values = _respuestas.values();
    HashSet<HandlerEvento> _hashSet = new HashSet<HandlerEvento>(_values);
    for (final HandlerEvento respuesta : _hashSet) {
      try {
        respuesta.manejar(data);
      } catch (final Throwable _t) {
        if (_t instanceof Exception) {
          final Exception e = (Exception)_t;
          a_eliminar.add(respuesta);
        } else {
          throw Exceptions.sneakyThrow(_t);
        }
      }
    }
    final Procedure1<HandlerEvento> _function = new Procedure1<HandlerEvento>() {
        public void apply(final HandlerEvento it) {
          Evento.this.desconectar(it);
        }
      };
    IterableExtensions.<HandlerEvento>forEach(a_eliminar, _function);
  }
  
  public HandlerEvento desconectar(final HandlerEvento respuesta) {
    HandlerEvento _xtrycatchfinallyexpression = null;
    try {
      Map<String,HandlerEvento> _respuestas = this.getRespuestas();
      HandlerEvento _remove = _respuestas.remove(respuesta);
      _xtrycatchfinallyexpression = _remove;
    } catch (final Throwable _t) {
      if (_t instanceof Exception) {
        final Exception e = (Exception)_t;
        RuntimeException _runtimeException = new RuntimeException("La funcion indicada no estaba agregada como respuesta del evento.");
        throw _runtimeException;
      } else {
        throw Exceptions.sneakyThrow(_t);
      }
    }
    return _xtrycatchfinallyexpression;
  }
  
  public void desconectarPorId(final String id) {
    final ArrayList<HandlerEvento> a_eliminar = CollectionLiterals.<HandlerEvento>newArrayList();
    Map<String,HandlerEvento> _respuestas = this.getRespuestas();
    Set<Entry<String,HandlerEvento>> _entrySet = _respuestas.entrySet();
    for (final Entry<String,HandlerEvento> respuesta : _entrySet) {
      String _key = respuesta.getKey();
      boolean _equals = Objects.equal(_key, id);
      if (_equals) {
        HandlerEvento _value = respuesta.getValue();
        a_eliminar.add(_value);
      }
    }
    for (final HandlerEvento x : a_eliminar) {
      this.desconectar(x);
    }
  }
  
  public HandlerEvento conectar(final String id, final HandlerEvento respuesta) {
    Map<String,HandlerEvento> _respuestas = this.getRespuestas();
    HandlerEvento _put = _respuestas.put(id, respuesta);
    return _put;
  }
}
