package org.uqbar.pilax.engine;

import com.google.common.base.Objects;
import com.trolltech.qt.core.Qt.MouseButton;
import java.util.ArrayList;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Exceptions;
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
  
  public Evento(final String string) {
    UnsupportedOperationException _unsupportedOperationException = new UnsupportedOperationException("TODO: auto-generated method stub");
    throw _unsupportedOperationException;
  }
  
  public void emitir(final int codigo, final boolean es_repeticion, final String texto) {
    UnsupportedOperationException _unsupportedOperationException = new UnsupportedOperationException("TODO: auto-generated method stub");
    throw _unsupportedOperationException;
  }
  
  public void emitir() {
    UnsupportedOperationException _unsupportedOperationException = new UnsupportedOperationException("TODO: auto-generated method stub");
    throw _unsupportedOperationException;
  }
  
  public void emitir(final float x, final float y, final float dx, final float dy) {
    UnsupportedOperationException _unsupportedOperationException = new UnsupportedOperationException("TODO: auto-generated method stub");
    throw _unsupportedOperationException;
  }
  
  public void emitir(final float x, final float y, final float dx, final float dy, final MouseButton botonPulsado) {
    UnsupportedOperationException _unsupportedOperationException = new UnsupportedOperationException("TODO: auto-generated method stub");
    throw _unsupportedOperationException;
  }
  
  public void emitir(final float delta) {
    UnsupportedOperationException _unsupportedOperationException = new UnsupportedOperationException("TODO: auto-generated method stub");
    throw _unsupportedOperationException;
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
