package org.uqbar.pilax.engine;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.uqbar.pilax.engine.EscenaBase;

@SuppressWarnings("all")
public class GestorEscenas {
  private List<EscenaBase> escenas = new Function0<List<EscenaBase>>() {
    public List<EscenaBase> apply() {
      ArrayList<EscenaBase> _newArrayList = CollectionLiterals.<EscenaBase>newArrayList();
      return _newArrayList;
    }
  }.apply();
  
  public void cambiarEscena(final EscenaBase escena) {
    this.limpiar();
    this.escenas.add(escena);
    escena.iniciar();
    escena.setIniciada(true);
  }
  
  public List<EscenaBase> limpiar() {
    List<EscenaBase> _xblockexpression = null;
    {
      final Procedure1<EscenaBase> _function = new Procedure1<EscenaBase>() {
          public void apply(final EscenaBase it) {
            it.limpiar();
          }
        };
      IterableExtensions.<EscenaBase>forEach(this.escenas, _function);
      ArrayList<EscenaBase> _newArrayList = CollectionLiterals.<EscenaBase>newArrayList();
      List<EscenaBase> _escenas = this.escenas = _newArrayList;
      _xblockexpression = (_escenas);
    }
    return _xblockexpression;
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
      final Procedure1<EscenaBase> _function = new Procedure1<EscenaBase>() {
          public void apply(final EscenaBase it) {
            it.actualizarFisica();
          }
        };
      IterableExtensions.<EscenaBase>forEach(this.escenas, _function);
    }
  }
}
