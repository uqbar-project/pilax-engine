package org.uqbar.pilax.engine;

import com.trolltech.qt.gui.QApplication;
import org.eclipse.xtext.xbase.lib.Pair;
import org.uqbar.pilax.engine.GestorEscenas;
import org.uqbar.pilax.engine.Mundo;
import org.uqbar.pilax.engine.PythonUtils;
import org.uqbar.pilax.engine.Ventana;
import org.uqbar.pilax.engine.motor.ActorMotor;

@SuppressWarnings("all")
public class Motor {
  private QApplication application;
  
  private int anchoOriginal;
  
  private int altoOriginal;
  
  private String titulo;
  
  private Ventana _ventana;
  
  public Ventana getVentana() {
    return this._ventana;
  }
  
  public void setVentana(final Ventana ventana) {
    this._ventana = ventana;
  }
  
  private int _camaraX = 0;
  
  public int getCamaraX() {
    return this._camaraX;
  }
  
  public void setCamaraX(final int camaraX) {
    this._camaraX = camaraX;
  }
  
  private int _camaraY = 0;
  
  public int getCamaraY() {
    return this._camaraY;
  }
  
  public void setCamaraY(final int camaraY) {
    this._camaraY = camaraY;
  }
  
  private boolean mostrarVentana;
  
  public Motor() {
  }
  
  public QApplication iniciarAplicacion() {
    QApplication _xblockexpression = null;
    {
      final String[] a = {};
      QApplication.initialize(a);
      QApplication _instance = QApplication.instance();
      QApplication _application = this.application = _instance;
      _xblockexpression = (_application);
    }
    return _xblockexpression;
  }
  
  public Object iniciarVentana(final int ancho, final int alto, final String nombre, final GestorEscenas gestor) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field canvas is undefined for the type Motor"
      + "\nThe method CanvasNormalWidget is undefined for the type Motor"
      + "\nThe method or field actores is undefined for the type Motor"
      + "\nThe method or field gestor_escenas is undefined for the type Motor"
      + "\nThe method permitir_depuracion is undefined for the type Motor"
      + "\nThe method or field rendimiento is undefined for the type Motor"
      + "\ntodos cannot be resolved");
  }
  
  public static void main(final String[] args) {
    Motor _motor = new Motor();
    _motor.iniciarAplicacion();
  }
  
  public ActorMotor obtenerActor(final String imagen, final int x, final int y) {
    ActorMotor _actorMotor = new ActorMotor(imagen, x, y);
    return _actorMotor;
  }
  
  /**
   * Centro de la ventana para situar el punto (0, 0)
   */
  public Pair<Integer,Integer> centroFisico() {
    Motor _self = PythonUtils.<Motor>self(this);
    int _divide = (_self.anchoOriginal / 2);
    Motor _self_1 = PythonUtils.<Motor>self(this);
    int _divide_1 = (_self_1.altoOriginal / 2);
    Pair<Integer,Integer> _mappedTo = Pair.<Integer, Integer>of(Integer.valueOf(_divide), Integer.valueOf(_divide_1));
    return _mappedTo;
  }
  
  public Pair<Integer,Integer> getArea() {
    Motor _self = PythonUtils.<Motor>self(this);
    Motor _self_1 = PythonUtils.<Motor>self(this);
    Pair<Integer,Integer> _mappedTo = Pair.<Integer, Integer>of(Integer.valueOf(_self.anchoOriginal), Integer.valueOf(_self_1.altoOriginal));
    return _mappedTo;
  }
  
  public int ejecutarBuclePrincipal(final Mundo mundo) {
    int _exec = QApplication.exec();
    return _exec;
  }
  
  public Pair<Integer,Integer> getCentroDeLaCamara() {
    Motor _self = PythonUtils.<Motor>self(this);
    int _camaraX = _self.getCamaraX();
    Motor _self_1 = PythonUtils.<Motor>self(this);
    int _camaraY = _self_1.getCamaraY();
    Pair<Integer,Integer> _mappedTo = Pair.<Integer, Integer>of(Integer.valueOf(_camaraX), Integer.valueOf(_camaraY));
    return _mappedTo;
  }
  
  public void setCentroDeLaCamara(final Pair<Integer,Integer> centro) {
    Motor _self = PythonUtils.<Motor>self(this);
    Integer _key = centro.getKey();
    _self.setCamaraX((_key).intValue());
    Motor _self_1 = PythonUtils.<Motor>self(this);
    Integer _value = centro.getValue();
    _self_1.setCamaraY((_value).intValue());
  }
}
