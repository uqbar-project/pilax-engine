package org.uqbar.pilax.engine;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.uqbar.pilax.engine.EscenaBase;

@SuppressWarnings("all")
public class GestorEscenas {
  private List<EscenaBase> escenas = new Function0<List<EscenaBase>>() {
    public List<EscenaBase> apply() {
      ArrayList<EscenaBase> _arrayList = new ArrayList<EscenaBase>();
      return _arrayList;
    }
  }.apply();
  
  public void cambiarEscena(final EscenaBase escena) {
    this.limpiar();
    this.escenas.add(escena);
    escena.iniciar();
    escena.setIniciada(true);
  }
  
  public void limpiar() {
    UnsupportedOperationException _unsupportedOperationException = new UnsupportedOperationException("TODO: auto-generated method stub");
    throw _unsupportedOperationException;
  }
  
  public EscenaBase escenaActual() {
    EscenaBase _xifexpression = null;
    boolean _isEmpty = this.escenas.isEmpty();
    boolean _not = (!_isEmpty);
    if (_not) {
      EscenaBase _last = IterableExtensions.<EscenaBase>last(this.escenas);
      _xifexpression = _last;
    } else {
      _xifexpression = null;
    }
    return _xifexpression;
  }
  
  public void actualizar() {
    final EscenaBase escena = this.escenaActual();
    boolean _notEquals = (!Objects.equal(escena, null));
    if (_notEquals) {
      boolean _isIniciada = escena.isIniciada();
      if (_isIniciada) {
        escena.actualizarEventos();
      }
      for (final EscenaBase e : this.escenas) {
        e.actualizarFisica();
      }
    }
  }
}
