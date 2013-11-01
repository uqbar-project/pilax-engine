package org.uqbar.pilax.engine;

import com.google.common.base.Objects;
import com.google.common.collect.Maps;
import java.util.Collections;
import java.util.Map;
import org.uqbar.pilax.engine.EscenaBase;
import org.uqbar.pilax.engine.Evento;
import org.uqbar.pilax.engine.HandlerEvento;
import org.uqbar.pilax.engine.PythonUtils;
import org.uqbar.pilax.engine.Simbolos;

@SuppressWarnings("all")
public class Control {
  private boolean _izquierda;
  
  public boolean isIzquierda() {
    return this._izquierda;
  }
  
  public void setIzquierda(final boolean izquierda) {
    this._izquierda = izquierda;
  }
  
  private boolean _derecha;
  
  public boolean isDerecha() {
    return this._derecha;
  }
  
  public void setDerecha(final boolean derecha) {
    this._derecha = derecha;
  }
  
  private boolean _arriba;
  
  public boolean isArriba() {
    return this._arriba;
  }
  
  public void setArriba(final boolean arriba) {
    this._arriba = arriba;
  }
  
  private boolean _abajo;
  
  public boolean isAbajo() {
    return this._abajo;
  }
  
  public void setAbajo(final boolean abajo) {
    this._abajo = abajo;
  }
  
  private boolean _boton;
  
  public boolean isBoton() {
    return this._boton;
  }
  
  public void setBoton(final boolean boton) {
    this._boton = boton;
  }
  
  private Map<Integer,String> mapa_teclado;
  
  public Control(final EscenaBase escena, final Map<Integer,String> mapa_teclado) {
    Evento _pulsaTecla = escena.getPulsaTecla();
    final HandlerEvento _function = new HandlerEvento() {
        public void manejar(final Evento e) {
          Control.this.cuando_pulsa_una_tecla(e);
        }
      };
    _pulsaTecla.conectar("control", _function);
    Evento _sueltaTecla = escena.getSueltaTecla();
    final HandlerEvento _function_1 = new HandlerEvento() {
        public void manejar(final Evento e) {
          Control.this.cuando_suelta_una_tecla(e);
        }
      };
    _sueltaTecla.conectar("control", _function_1);
    Object _None = PythonUtils.<Object>None(this);
    boolean _equals = Objects.equal(mapa_teclado, _None);
    if (_equals) {
      Control _self = PythonUtils.<Control>self(this);
      Map<Integer,String> _xsetliteral = null;
      Map<Integer,String> _tempMap = Maps.<Integer, String>newHashMap();
      _tempMap.put(Integer.valueOf(Simbolos.IZQUIERDA), "izquierda");
      _tempMap.put(Integer.valueOf(Simbolos.DERECHA), "derecha");
      _tempMap.put(Integer.valueOf(Simbolos.ARRIBA), "arriba");
      _tempMap.put(Integer.valueOf(Simbolos.ABAJO), "abajo");
      _tempMap.put(Integer.valueOf(Simbolos.ESPACIO), "boton");
      _xsetliteral = Collections.<Integer, String>unmodifiableMap(_tempMap);
      _self.mapa_teclado = _xsetliteral;
    } else {
      Control _self_1 = PythonUtils.<Control>self(this);
      _self_1.mapa_teclado = mapa_teclado;
    }
  }
  
  public Object cuando_pulsa_una_tecla(final Evento evento) {
    Control _self = PythonUtils.<Control>self(this);
    Integer _codigo = evento.getCodigo();
    Object _procesar_cambio_de_estado_en_la_tecla = _self.procesar_cambio_de_estado_en_la_tecla(_codigo, true);
    return _procesar_cambio_de_estado_en_la_tecla;
  }
  
  public Object cuando_suelta_una_tecla(final Evento evento) {
    Control _self = PythonUtils.<Control>self(this);
    Integer _codigo = evento.getCodigo();
    Object _procesar_cambio_de_estado_en_la_tecla = _self.procesar_cambio_de_estado_en_la_tecla(_codigo, false);
    return _procesar_cambio_de_estado_en_la_tecla;
  }
  
  public Object procesar_cambio_de_estado_en_la_tecla(final Integer codigo, final boolean estado) {
    Object _xifexpression = null;
    Control _self = PythonUtils.<Control>self(this);
    boolean _containsKey = _self.mapa_teclado.containsKey(codigo);
    if (_containsKey) {
      Control _self_1 = PythonUtils.<Control>self(this);
      Control _self_2 = PythonUtils.<Control>self(this);
      String _get = _self_2.mapa_teclado.get(codigo);
      Object _setattr = PythonUtils.setattr(_self_1, _get, Boolean.valueOf(estado));
      _xifexpression = _setattr;
    }
    return _xifexpression;
  }
  
  public void limpiar() {
    Control _self = PythonUtils.<Control>self(this);
    boolean _False = PythonUtils.False(this);
    _self.setIzquierda(_False);
    Control _self_1 = PythonUtils.<Control>self(this);
    boolean _False_1 = PythonUtils.False(this);
    _self_1.setDerecha(_False_1);
    Control _self_2 = PythonUtils.<Control>self(this);
    boolean _False_2 = PythonUtils.False(this);
    _self_2.setArriba(_False_2);
    Control _self_3 = PythonUtils.<Control>self(this);
    boolean _False_3 = PythonUtils.False(this);
    _self_3.setAbajo(_False_3);
    Control _self_4 = PythonUtils.<Control>self(this);
    boolean _False_4 = PythonUtils.False(this);
    _self_4.setBoton(_False_4);
  }
}
