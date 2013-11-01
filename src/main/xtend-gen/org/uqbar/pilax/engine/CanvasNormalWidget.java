package org.uqbar.pilax.engine;

import com.google.common.base.Objects;
import com.google.common.collect.Maps;
import com.trolltech.qt.core.QPoint;
import com.trolltech.qt.core.QTimerEvent;
import com.trolltech.qt.core.Qt.Key;
import com.trolltech.qt.core.Qt.MouseButton;
import com.trolltech.qt.gui.QColor;
import com.trolltech.qt.gui.QKeyEvent;
import com.trolltech.qt.gui.QMouseEvent;
import com.trolltech.qt.gui.QPaintDeviceInterface;
import com.trolltech.qt.gui.QPaintEvent;
import com.trolltech.qt.gui.QPainter;
import com.trolltech.qt.gui.QPainter.RenderHint;
import com.trolltech.qt.gui.QWheelEvent;
import com.trolltech.qt.gui.QWidget;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.IntegerRange;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Pair;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.uqbar.pilax.engine.Actor;
import org.uqbar.pilax.engine.ActorPausa;
import org.uqbar.pilax.engine.DepuradorDeshabilitado;
import org.uqbar.pilax.engine.EscenaBase;
import org.uqbar.pilax.engine.Evento;
import org.uqbar.pilax.engine.FPS;
import org.uqbar.pilax.engine.GestorEscenas;
import org.uqbar.pilax.engine.HandlerEvento;
import org.uqbar.pilax.engine.Motor;
import org.uqbar.pilax.engine.Mundo;
import org.uqbar.pilax.engine.Pilas;
import org.uqbar.pilax.engine.PilasExtensions;
import org.uqbar.pilax.engine.PythonUtils;
import org.uqbar.pilax.engine.Simbolos;
import org.uqbar.pilax.engine.Utils;
import org.uqbar.pilax.engine.Ventana;

@SuppressWarnings("all")
public class CanvasNormalWidget extends QWidget {
  private QPainter painter;
  
  private boolean pausaHabilitada;
  
  private int mouseX;
  
  private int mouseY;
  
  private Motor motor;
  
  private List<Actor> listaActores;
  
  private FPS fps;
  
  private float escala;
  
  private int original_width;
  
  private int original_height;
  
  private DepuradorDeshabilitado depurador;
  
  private GestorEscenas gestorEscenas;
  
  private ActorPausa actorPausa;
  
  public CanvasNormalWidget(final Motor motor, final List<Actor> lista_actores, final int ancho, final int alto, final GestorEscenas gestor_escenas, final boolean permitir_depuracion, final double rendimiento) {
    super(null);
    QPainter _qPainter = new QPainter();
    this.painter = _qPainter;
    this.setMouseTracking(true);
    this.pausaHabilitada = false;
    this.mouseX = 0;
    this.mouseY = 0;
    this.motor = motor;
    this.listaActores = lista_actores;
    FPS _fPS = new FPS(rendimiento, true);
    this.fps = _fPS;
    DepuradorDeshabilitado _depuradorDeshabilitado = new DepuradorDeshabilitado();
    this.depurador = _depuradorDeshabilitado;
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    _self.original_width = ancho;
    CanvasNormalWidget _self_1 = PythonUtils.<CanvasNormalWidget>self(this);
    _self_1.original_height = alto;
    CanvasNormalWidget _self_2 = PythonUtils.<CanvasNormalWidget>self(this);
    _self_2.escala = 1;
    CanvasNormalWidget _self_3 = PythonUtils.<CanvasNormalWidget>self(this);
    int _divide = (1000 / 100);
    _self_3.startTimer(_divide);
    this.gestorEscenas = gestor_escenas;
  }
  
  public void resize_to(final int w, final int h) {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    Float _valueOf = Float.valueOf(_self.original_width);
    final float escala_x = (w / (_valueOf).floatValue());
    CanvasNormalWidget _self_1 = PythonUtils.<CanvasNormalWidget>self(this);
    Float _valueOf_1 = Float.valueOf(_self_1.original_height);
    final float escala_y = (h / (_valueOf_1).floatValue());
    final float escala = Math.min(escala_x, escala_y);
    CanvasNormalWidget _self_2 = PythonUtils.<CanvasNormalWidget>self(this);
    float _multiply = (_self_2.original_width * escala);
    final int final_w = Float.valueOf(_multiply).intValue();
    CanvasNormalWidget _self_3 = PythonUtils.<CanvasNormalWidget>self(this);
    float _multiply_1 = (_self_3.original_height * escala);
    final int final_h = Float.valueOf(_multiply_1).intValue();
    CanvasNormalWidget _self_4 = PythonUtils.<CanvasNormalWidget>self(this);
    _self_4.escala = escala;
    final int x = (w - final_w);
    final int y = (h - final_h);
    CanvasNormalWidget _self_5 = PythonUtils.<CanvasNormalWidget>self(this);
    int _divide = (x / 2);
    int _divide_1 = (y / 2);
    _self_5.setGeometry(_divide, _divide_1, final_w, final_h);
  }
  
  protected void paintEvent(final QPaintEvent event) {
    QPaintDeviceInterface _device = this.painter.device();
    this.painter.begin(_device);
    this.painter.scale(this.escala, this.escala);
    this.painter.setRenderHint(RenderHint.HighQualityAntialiasing, true);
    this.painter.setRenderHint(RenderHint.SmoothPixmapTransform, true);
    this.painter.setRenderHint(RenderHint.Antialiasing, true);
    QColor _qColor = new QColor(128, 128, 128);
    this.painter.fillRect(0, 0, this.original_width, this.original_height, _qColor);
    this.depurador.comienza_dibujado(this.motor, this.painter);
    EscenaBase _escenaActual = this.gestorEscenas.escenaActual();
    boolean _notEquals = (!Objects.equal(_escenaActual, null));
    if (_notEquals) {
      CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
      EscenaBase _escenaActual_1 = _self.gestorEscenas.escenaActual();
      final List<Actor> actores_de_la_escena = _escenaActual_1.getActores();
      for (final Actor actor : actores_de_la_escena) {
        {
          try {
            boolean _estaFueraDeLaPantalla = actor.estaFueraDeLaPantalla();
            boolean _not = (!_estaFueraDeLaPantalla);
            if (_not) {
              CanvasNormalWidget _self_1 = PythonUtils.<CanvasNormalWidget>self(this);
              actor.dibujar(_self_1.painter);
            }
          } catch (final Throwable _t) {
            if (_t instanceof Exception) {
              final Exception e = (Exception)_t;
              e.printStackTrace();
              actor.eliminar();
            } else {
              throw Exceptions.sneakyThrow(_t);
            }
          }
          CanvasNormalWidget _self_2 = PythonUtils.<CanvasNormalWidget>self(this);
          CanvasNormalWidget _self_3 = PythonUtils.<CanvasNormalWidget>self(this);
          CanvasNormalWidget _self_4 = PythonUtils.<CanvasNormalWidget>self(this);
          _self_2.depurador.dibuja_al_actor(_self_3.motor, _self_4.painter, actor);
        }
      }
    }
    CanvasNormalWidget _self_1 = PythonUtils.<CanvasNormalWidget>self(this);
    CanvasNormalWidget _self_2 = PythonUtils.<CanvasNormalWidget>self(this);
    CanvasNormalWidget _self_3 = PythonUtils.<CanvasNormalWidget>self(this);
    _self_1.depurador.termina_dibujado(_self_2.motor, _self_3.painter);
    CanvasNormalWidget _self_4 = PythonUtils.<CanvasNormalWidget>self(this);
    _self_4.painter.end();
  }
  
  protected void timerEvent(final QTimerEvent event) {
    try {
      CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
      _self._realizarActualizacionLogica();
    } catch (final Throwable _t) {
      if (_t instanceof Exception) {
        final Exception e = (Exception)_t;
        e.printStackTrace();
      } else {
        throw Exceptions.sneakyThrow(_t);
      }
    }
    CanvasNormalWidget _self_1 = PythonUtils.<CanvasNormalWidget>self(this);
    _self_1.update();
  }
  
  public void _realizarActualizacionLogica() {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    int _actualizar = _self.fps.actualizar();
    IntegerRange _range = PythonUtils.range(_actualizar);
    for (final Integer x : _range) {
      CanvasNormalWidget _self_1 = PythonUtils.<CanvasNormalWidget>self(this);
      boolean _not = (!_self_1.pausaHabilitada);
      if (_not) {
        CanvasNormalWidget _self_2 = PythonUtils.<CanvasNormalWidget>self(this);
        _self_2.actualizar_eventos_y_actores();
        CanvasNormalWidget _self_3 = PythonUtils.<CanvasNormalWidget>self(this);
        _self_3.actualizarEscena();
      }
    }
  }
  
  protected void actualizarEscena() {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    _self.gestorEscenas.actualizar();
  }
  
  public void actualizar_eventos_y_actores() {
    Pilas _instance = Pilas.instance();
    EscenaBase _escenaActual = _instance.escenaActual();
    Evento _actualizar = _escenaActual.getActualizar();
    _actualizar.emitir();
    try {
      CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
      EscenaBase _escenaActual_1 = _self.gestorEscenas.escenaActual();
      List<Actor> _actores = _escenaActual_1.getActores();
      final Procedure1<Actor> _function = new Procedure1<Actor>() {
          public void apply(final Actor it) {
            it.preActualizar();
            it.actualizar();
          }
        };
      IterableExtensions.<Actor>forEach(_actores, _function);
    } catch (final Throwable _t) {
      if (_t instanceof Exception) {
        final Exception e = (Exception)_t;
        e.printStackTrace();
      } else {
        throw Exceptions.sneakyThrow(_t);
      }
    }
  }
  
  protected void mouseMoveEvent(final QMouseEvent e) {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    final float escala = _self.escala;
    QPoint _pos = e.pos();
    int _x = _pos.x();
    float _divide = (_x / escala);
    QPoint _pos_1 = e.pos();
    int _y = _pos_1.y();
    float _divide_1 = (_y / escala);
    final Pair<Float,Float> posRelativa = Utils.convertirDePosicionFisicaRelativa(_divide, _divide_1);
    Float x = posRelativa.getKey();
    Float y = posRelativa.getValue();
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    Motor _motor = _mundo.getMotor();
    int _camaraX = _motor.getCamaraX();
    float _plus = ((x).floatValue() + _camaraX);
    x = Float.valueOf(_plus);
    Pilas _instance_1 = Pilas.instance();
    Mundo _mundo_1 = _instance_1.getMundo();
    Motor _motor_1 = _mundo_1.getMotor();
    int _camaraY = _motor_1.getCamaraY();
    float _plus_1 = ((y).floatValue() + _camaraY);
    y = Float.valueOf(_plus_1);
    CanvasNormalWidget _self_1 = PythonUtils.<CanvasNormalWidget>self(this);
    final float dx = ((x).floatValue() - _self_1.mouseX);
    CanvasNormalWidget _self_2 = PythonUtils.<CanvasNormalWidget>self(this);
    final float dy = ((y).floatValue() - _self_2.mouseY);
    CanvasNormalWidget _self_3 = PythonUtils.<CanvasNormalWidget>self(this);
    EscenaBase _escenaActual = _self_3.gestorEscenas.escenaActual();
    Evento _mueveMouse = _escenaActual.getMueveMouse();
    _mueveMouse.emitir((x).floatValue(), (y).floatValue(), dx, dy);
    CanvasNormalWidget _self_4 = PythonUtils.<CanvasNormalWidget>self(this);
    int _intValue = x.intValue();
    _self_4.mouseX = _intValue;
    CanvasNormalWidget _self_5 = PythonUtils.<CanvasNormalWidget>self(this);
    int _intValue_1 = y.intValue();
    _self_5.mouseY = _intValue_1;
    CanvasNormalWidget _self_6 = PythonUtils.<CanvasNormalWidget>self(this);
    int _intValue_2 = x.intValue();
    int _intValue_3 = y.intValue();
    _self_6.depurador.cuando_mueve_el_mouse(_intValue_2, _intValue_3);
  }
  
  protected void keyPressEvent(final QKeyEvent event) {
    throw new Error("Unresolved compilation problems:"
      + "\nType mismatch: cannot convert from Object to int");
  }
  
  protected void keyReleaseEvent(final QKeyEvent event) {
    throw new Error("Unresolved compilation problems:"
      + "\nType mismatch: cannot convert from Object to int");
  }
  
  protected void wheelEvent(final QWheelEvent e) {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    EscenaBase _escenaActual = _self.gestorEscenas.escenaActual();
    Evento _mueveRueda = _escenaActual.getMueveRueda();
    int _delta = e.delta();
    int _divide = (_delta / 120);
    _mueveRueda.emitir(_divide);
  }
  
  protected void mousePressEvent(final QMouseEvent e) {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    final float escala = _self.escala;
    QPoint _pos = e.pos();
    int _x = _pos.x();
    float _divide = (_x / escala);
    QPoint _pos_1 = e.pos();
    int _y = _pos_1.y();
    float _divide_1 = (_y / escala);
    final Pair<Float,Float> posRelativa = Utils.convertirDePosicionFisicaRelativa(_divide, _divide_1);
    Float x = posRelativa.getKey();
    Float y = posRelativa.getValue();
    final MouseButton boton_pulsado = e.button();
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    Motor _motor = _mundo.getMotor();
    int _camaraX = _motor.getCamaraX();
    float _plus = ((x).floatValue() + _camaraX);
    x = Float.valueOf(_plus);
    Pilas _instance_1 = Pilas.instance();
    Mundo _mundo_1 = _instance_1.getMundo();
    Motor _motor_1 = _mundo_1.getMotor();
    int _camaraY = _motor_1.getCamaraY();
    float _plus_1 = ((y).floatValue() + _camaraY);
    y = Float.valueOf(_plus_1);
    CanvasNormalWidget _self_1 = PythonUtils.<CanvasNormalWidget>self(this);
    EscenaBase _escenaActual = _self_1.gestorEscenas.escenaActual();
    Evento _clickDeMouse = _escenaActual.getClickDeMouse();
    _clickDeMouse.emitir((x).floatValue(), (y).floatValue(), 0, 0, boton_pulsado);
  }
  
  protected void mouseReleaseEvent(final QMouseEvent e) {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    final float escala = _self.escala;
    QPoint _pos = e.pos();
    int _x = _pos.x();
    float _divide = (_x / escala);
    QPoint _pos_1 = e.pos();
    int _y = _pos_1.y();
    float _divide_1 = (_y / escala);
    final Pair<Float,Float> posRelativa = Utils.convertirDePosicionFisicaRelativa(_divide, _divide_1);
    Float x = posRelativa.getKey();
    Float y = posRelativa.getValue();
    final MouseButton boton_pulsado = e.button();
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    Motor _motor = _mundo.getMotor();
    int _camaraX = _motor.getCamaraX();
    float _plus = ((x).floatValue() + _camaraX);
    x = Float.valueOf(_plus);
    Pilas _instance_1 = Pilas.instance();
    Mundo _mundo_1 = _instance_1.getMundo();
    Motor _motor_1 = _mundo_1.getMotor();
    int _camaraY = _motor_1.getCamaraY();
    float _plus_1 = ((y).floatValue() + _camaraY);
    y = Float.valueOf(_plus_1);
    CanvasNormalWidget _self_1 = PythonUtils.<CanvasNormalWidget>self(this);
    EscenaBase _escenaActual = _self_1.gestorEscenas.escenaActual();
    Evento _terminaClick = _escenaActual.getTerminaClick();
    _terminaClick.emitir((x).floatValue(), (y).floatValue(), 0, 0, boton_pulsado);
  }
  
  public Object _obtener_codigo_de_tecla_normalizado(final int tecla_qt) {
    Map<Key,Object> _xsetliteral = null;
    Map<Key,Object> _tempMap = Maps.<Key, Object>newHashMap();
    _tempMap.put(Key.Key_Left, Integer.valueOf(Simbolos.IZQUIERDA));
    _tempMap.put(Key.Key_Right, Integer.valueOf(Simbolos.DERECHA));
    _tempMap.put(Key.Key_Up, Integer.valueOf(Simbolos.ARRIBA));
    _tempMap.put(Key.Key_Down, Integer.valueOf(Simbolos.ABAJO));
    _tempMap.put(Key.Key_Space, Integer.valueOf(Simbolos.ESPACIO));
    _tempMap.put(Key.Key_Return, Integer.valueOf(Simbolos.SELECCION));
    _tempMap.put(Key.Key_F1, Simbolos.F1);
    _tempMap.put(Key.Key_F2, Simbolos.F2);
    _tempMap.put(Key.Key_F3, Simbolos.F3);
    _tempMap.put(Key.Key_F4, Simbolos.F4);
    _tempMap.put(Key.Key_F5, Simbolos.F5);
    _tempMap.put(Key.Key_F6, Simbolos.F6);
    _tempMap.put(Key.Key_F7, Simbolos.F7);
    _tempMap.put(Key.Key_F8, Simbolos.F8);
    _tempMap.put(Key.Key_F9, Simbolos.F9);
    _tempMap.put(Key.Key_F10, Simbolos.F10);
    _tempMap.put(Key.Key_F11, Simbolos.F11);
    _tempMap.put(Key.Key_F12, Simbolos.F12);
    _tempMap.put(Key.Key_A, Simbolos.a);
    _tempMap.put(Key.Key_B, Simbolos.b);
    _tempMap.put(Key.Key_C, Simbolos.c);
    _tempMap.put(Key.Key_D, Simbolos.d);
    _tempMap.put(Key.Key_E, Simbolos.e);
    _tempMap.put(Key.Key_F, Simbolos.f);
    _tempMap.put(Key.Key_G, Simbolos.g);
    _tempMap.put(Key.Key_H, Simbolos.h);
    _tempMap.put(Key.Key_I, Simbolos.i);
    _tempMap.put(Key.Key_J, Simbolos.j);
    _tempMap.put(Key.Key_K, Simbolos.k);
    _tempMap.put(Key.Key_L, Simbolos.l);
    _tempMap.put(Key.Key_M, Simbolos.m);
    _tempMap.put(Key.Key_N, Simbolos.n);
    _tempMap.put(Key.Key_O, Simbolos.o);
    _tempMap.put(Key.Key_P, Simbolos.p);
    _tempMap.put(Key.Key_Q, Simbolos.q);
    _tempMap.put(Key.Key_R, Simbolos.r);
    _tempMap.put(Key.Key_S, Simbolos.s);
    _tempMap.put(Key.Key_T, Simbolos.t);
    _tempMap.put(Key.Key_U, Simbolos.u);
    _tempMap.put(Key.Key_V, Simbolos.v);
    _tempMap.put(Key.Key_W, Simbolos.w);
    _tempMap.put(Key.Key_X, Simbolos.x);
    _tempMap.put(Key.Key_Y, Simbolos.y);
    _tempMap.put(Key.Key_Z, Simbolos.z);
    _xsetliteral = Collections.<Key, Object>unmodifiableMap(_tempMap);
    final Map<Key,Object> teclas = _xsetliteral;
    boolean _containsKey = teclas.containsKey(Integer.valueOf(tecla_qt));
    if (_containsKey) {
      return teclas.get(Integer.valueOf(tecla_qt));
    } else {
      return tecla_qt;
    }
  }
  
  public void pantallaCompleta() {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    Ventana _ventana = _self.motor.getVentana();
    _ventana.showFullScreen();
  }
  
  public void pantalla_modo_ventana() {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    Ventana _ventana = _self.motor.getVentana();
    _ventana.showNormal();
  }
  
  public boolean esta_en_pantalla_completa() {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    Ventana _ventana = _self.motor.getVentana();
    return _ventana.isFullScreen();
  }
  
  public HandlerEvento alternar_pausa() {
    HandlerEvento _xifexpression = null;
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    if (_self.pausaHabilitada) {
      CanvasNormalWidget _self_1 = PythonUtils.<CanvasNormalWidget>self(this);
      _self_1.pausaHabilitada = false;
      CanvasNormalWidget _self_2 = PythonUtils.<CanvasNormalWidget>self(this);
      _self_2.actorPausa.eliminar();
      EscenaBase _eventos = PilasExtensions.eventos(this);
      Evento _pulsaTecla = _eventos.getPulsaTecla();
      _pulsaTecla.desconectarPorId("tecla_en_pausa");
    } else {
      HandlerEvento _xblockexpression = null;
      {
        CanvasNormalWidget _self_3 = PythonUtils.<CanvasNormalWidget>self(this);
        _self_3.pausaHabilitada = true;
        CanvasNormalWidget _self_4 = PythonUtils.<CanvasNormalWidget>self(this);
        ActorPausa _actorPausa = new ActorPausa();
        _self_4.actorPausa = _actorPausa;
        CanvasNormalWidget _self_5 = PythonUtils.<CanvasNormalWidget>self(this);
        _self_5.actorPausa.setFijo(true);
        EscenaBase _eventos_1 = PilasExtensions.eventos(this);
        Evento _pulsaTecla_1 = _eventos_1.getPulsaTecla();
        final HandlerEvento _function = new HandlerEvento() {
            public void manejar(final Evento e) {
              CanvasNormalWidget.this.avanzar_un_solo_cuadro_de_animacion(e);
            }
          };
        HandlerEvento _conectar = _pulsaTecla_1.conectar("tecla_en_pausa", _function);
        _xblockexpression = (_conectar);
      }
      _xifexpression = _xblockexpression;
    }
    return _xifexpression;
  }
  
  public void avanzar_un_solo_cuadro_de_animacion(final Evento evento) {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    _self.actualizar_eventos_y_actores();
  }
  
  /**
   * Permite cambiar el modo de video.
   * Si está en modo ventana, pasa a pantalla completa y viceversa.
   */
  public void alternar_pantalla_completa() {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    boolean _esta_en_pantalla_completa = _self.esta_en_pantalla_completa();
    if (_esta_en_pantalla_completa) {
      CanvasNormalWidget _self_1 = PythonUtils.<CanvasNormalWidget>self(this);
      _self_1.pantalla_modo_ventana();
    } else {
      CanvasNormalWidget _self_2 = PythonUtils.<CanvasNormalWidget>self(this);
      _self_2.pantallaCompleta();
    }
  }
}
