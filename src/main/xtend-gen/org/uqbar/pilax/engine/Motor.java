package org.uqbar.pilax.engine;

import com.trolltech.qt.gui.QApplication;
import java.util.List;
import org.eclipse.xtext.xbase.lib.Pair;
import org.uqbar.pilax.engine.Actor;
import org.uqbar.pilax.engine.CanvasNormalWidget;
import org.uqbar.pilax.engine.GestorEscenas;
import org.uqbar.pilax.engine.Mundo;
import org.uqbar.pilax.engine.Pilas;
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
  
  private CanvasNormalWidget canvas;
  
  private boolean permitirDepuracion = false;
  
  public Motor() {
    Motor _self = PythonUtils.<Motor>self(this);
    _self.iniciarAplicacion();
  }
  
  public QApplication iniciarAplicacion() {
    QApplication _xblockexpression = null;
    {
      String[] _newArrayOfSize = new String[0];
      QApplication.initialize(_newArrayOfSize);
      QApplication _instance = QApplication.instance();
      QApplication _application = this.application = _instance;
      _xblockexpression = (_application);
    }
    return _xblockexpression;
  }
  
  public void iniciarVentana(final int ancho, final int alto, final String titulo, final boolean pantalla_completa, final GestorEscenas gestor, final float rendimiento) {
    this.anchoOriginal = ancho;
    this.altoOriginal = alto;
    Motor _self = PythonUtils.<Motor>self(this);
    _self.titulo = titulo;
    Motor _self_1 = PythonUtils.<Motor>self(this);
    Ventana _ventana = new Ventana(null);
    _self_1.setVentana(_ventana);
    Motor _self_2 = PythonUtils.<Motor>self(this);
    Ventana _ventana_1 = _self_2.getVentana();
    _ventana_1.resize(ancho, alto);
    Motor _self_3 = PythonUtils.<Motor>self(this);
    Ventana _ventana_2 = _self_3.getVentana();
    Motor _self_4 = PythonUtils.<Motor>self(this);
    _ventana_2.setWindowTitle(_self_4.titulo);
    Motor _self_5 = PythonUtils.<Motor>self(this);
    Motor _self_6 = PythonUtils.<Motor>self(this);
    Pilas _instance = Pilas.instance();
    List<Actor> _todosActores = _instance.getTodosActores();
    Motor _self_7 = PythonUtils.<Motor>self(this);
    CanvasNormalWidget _canvasNormalWidget = new CanvasNormalWidget(_self_6, _todosActores, ancho, alto, gestor, _self_7.permitirDepuracion, rendimiento);
    _self_5.canvas = _canvasNormalWidget;
    Motor _self_8 = PythonUtils.<Motor>self(this);
    Ventana _ventana_3 = _self_8.getVentana();
    Motor _self_9 = PythonUtils.<Motor>self(this);
    _ventana_3.setCanvas(_self_9.canvas);
    Motor _self_10 = PythonUtils.<Motor>self(this);
    _self_10.canvas.setFocus();
    if (true) {
      Motor _self_11 = PythonUtils.<Motor>self(this);
      Ventana _ventana_4 = _self_11.getVentana();
      _ventana_4.show();
      Motor _self_12 = PythonUtils.<Motor>self(this);
      Ventana _ventana_5 = _self_12.getVentana();
      _ventana_5.raise();
    }
    if (pantalla_completa) {
      Motor _self_13 = PythonUtils.<Motor>self(this);
      _self_13.canvas.pantallaCompleta();
    }
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
