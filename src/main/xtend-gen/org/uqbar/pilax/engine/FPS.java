package org.uqbar.pilax.engine;

import com.trolltech.qt.core.QTime;
import org.uqbar.pilax.engine.PythonUtils;

@SuppressWarnings("all")
public class FPS {
  private String cuadros_por_segundo = "??";
  
  private double frecuencia;
  
  private double siguiente;
  
  private QTime timer;
  
  private int cuadros;
  
  private double ultimo_reporte_fps;
  
  private int cuadros_por_segundo_numerico;
  
  public FPS(final double fps, final boolean usarModoEconomico) {
    FPS _self = PythonUtils.<FPS>self(this);
    _self.cuadros_por_segundo = "??";
    FPS _self_1 = PythonUtils.<FPS>self(this);
    double _divide = (1000.0 / fps);
    _self_1.frecuencia = _divide;
    FPS _self_2 = PythonUtils.<FPS>self(this);
    QTime _qTime = new QTime();
    _self_2.timer = _qTime;
    FPS _self_3 = PythonUtils.<FPS>self(this);
    _self_3.timer.start();
    FPS _self_4 = PythonUtils.<FPS>self(this);
    FPS _self_5 = PythonUtils.<FPS>self(this);
    int _elapsed = _self_5.timer.elapsed();
    FPS _self_6 = PythonUtils.<FPS>self(this);
    double _plus = (_elapsed + _self_6.frecuencia);
    _self_4.siguiente = _plus;
    FPS _self_7 = PythonUtils.<FPS>self(this);
    _self_7.cuadros = 0;
    FPS _self_8 = PythonUtils.<FPS>self(this);
    _self_8.ultimo_reporte_fps = 0;
    FPS _self_9 = PythonUtils.<FPS>self(this);
    _self_9.cuadros_por_segundo_numerico = 0;
  }
  
  public int actualizar() {
    FPS _self = PythonUtils.<FPS>self(this);
    int actual = _self.timer.elapsed();
    FPS _self_1 = PythonUtils.<FPS>self(this);
    boolean _greaterThan = (actual > _self_1.siguiente);
    if (_greaterThan) {
      int cantidad = 0;
      FPS _self_2 = PythonUtils.<FPS>self(this);
      boolean _greaterThan_1 = (actual > _self_2.siguiente);
      boolean _while = _greaterThan_1;
      while (_while) {
        {
          FPS _self_3 = PythonUtils.<FPS>self(this);
          FPS _self_4 = PythonUtils.<FPS>self(this);
          FPS _self_5 = PythonUtils.<FPS>self(this);
          double _plus = (_self_4.siguiente + _self_5.frecuencia);
          _self_3.siguiente = _plus;
          int _plus_1 = (cantidad + 1);
          cantidad = _plus_1;
          FPS _self_6 = PythonUtils.<FPS>self(this);
          _self_6._procesar_fps(actual);
        }
        FPS _self_3 = PythonUtils.<FPS>self(this);
        boolean _greaterThan_2 = (actual > _self_3.siguiente);
        _while = _greaterThan_2;
      }
      boolean _greaterThan_2 = (cantidad > 10);
      if (_greaterThan_2) {
        cantidad = 10;
      }
      FPS _self_3 = PythonUtils.<FPS>self(this);
      FPS _self_4 = PythonUtils.<FPS>self(this);
      int _plus = (_self_4.cuadros + 1);
      _self_3.cuadros = _plus;
      return cantidad;
    } else {
      return 0;
    }
  }
  
  public Integer _procesar_fps(final double actual) {
    Integer _xifexpression = null;
    FPS _self = PythonUtils.<FPS>self(this);
    double _minus = (actual - _self.ultimo_reporte_fps);
    boolean _greaterThan = (_minus > 1000.0);
    if (_greaterThan) {
      int _xblockexpression = (int) 0;
      {
        FPS _self_1 = PythonUtils.<FPS>self(this);
        double _plus = (this.ultimo_reporte_fps + 1000.0);
        _self_1.ultimo_reporte_fps = _plus;
        FPS _self_2 = PythonUtils.<FPS>self(this);
        FPS _self_3 = PythonUtils.<FPS>self(this);
        String _valueOf = String.valueOf(_self_3.cuadros);
        _self_2.cuadros_por_segundo = _valueOf;
        FPS _self_4 = PythonUtils.<FPS>self(this);
        FPS _self_5 = PythonUtils.<FPS>self(this);
        _self_4.cuadros_por_segundo_numerico = _self_5.cuadros;
        FPS _self_6 = PythonUtils.<FPS>self(this);
        int _cuadros = _self_6.cuadros = 0;
        _xblockexpression = (_cuadros);
      }
      _xifexpression = Integer.valueOf(_xblockexpression);
    }
    return _xifexpression;
  }
}
