package org.uqbar.pilax.engine;

import com.google.common.base.Objects;
import com.google.common.collect.Maps;
import com.trolltech.qt.core.QPoint;
import com.trolltech.qt.core.QTimerEvent;
import com.trolltech.qt.core.Qt.Key;
import com.trolltech.qt.core.Qt.KeyboardModifier;
import com.trolltech.qt.core.Qt.KeyboardModifiers;
import com.trolltech.qt.core.Qt.MouseButton;
import com.trolltech.qt.gui.QColor;
import com.trolltech.qt.gui.QKeyEvent;
import com.trolltech.qt.gui.QMouseEvent;
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
import org.uqbar.pilax.engine.DataEvento;
import org.uqbar.pilax.engine.DataEventoMouse;
import org.uqbar.pilax.engine.DataEventoRuedaMouse;
import org.uqbar.pilax.engine.DataEventoTeclado;
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
    super(((QWidget) null));
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
    QPainter _qPainter = new QPainter();
    this.painter = _qPainter;
    this.painter.begin(this);
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
      _self.realizarActualizacionLogica();
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
  
  public void realizarActualizacionLogica() {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    int _actualizar = _self.fps.actualizar();
    IntegerRange _range = PythonUtils.range(_actualizar);
    for (final Integer x : _range) {
      CanvasNormalWidget _self_1 = PythonUtils.<CanvasNormalWidget>self(this);
      boolean _not = (!_self_1.pausaHabilitada);
      if (_not) {
        CanvasNormalWidget _self_2 = PythonUtils.<CanvasNormalWidget>self(this);
        _self_2.actualizarEventosYActores();
        CanvasNormalWidget _self_3 = PythonUtils.<CanvasNormalWidget>self(this);
        _self_3.actualizarEscena();
      }
    }
  }
  
  protected void actualizarEscena() {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    _self.gestorEscenas.actualizar();
  }
  
  public void actualizarEventosYActores() {
    Pilas _instance = Pilas.instance();
    EscenaBase _escenaActual = _instance.escenaActual();
    Evento _actualizar = _escenaActual.getActualizar();
    DataEvento _dataEvento = new DataEvento();
    _actualizar.emitir(_dataEvento);
    try {
      EscenaBase _escenaActual_1 = this.gestorEscenas.escenaActual();
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
    DataEventoMouse _dataEventoMouse = new DataEventoMouse(x, y, Float.valueOf(dx), Float.valueOf(dy), null);
    _mueveMouse.emitir(_dataEventoMouse);
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
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    int _key = event.key();
    final Object codigo_de_tecla = _self._obtener_codigo_de_tecla_normalizado(_key);
    int _key_1 = event.key();
    boolean _equals = Objects.equal(Integer.valueOf(_key_1), Key.Key_Escape);
    if (_equals) {
      EscenaBase _eventos = PilasExtensions.eventos(this);
      Evento _pulsaTeclaEscape = _eventos.getPulsaTeclaEscape();
      DataEvento _dataEvento = new DataEvento();
      _pulsaTeclaEscape.emitir(_dataEvento);
    }
    boolean _and = false;
    int _key_2 = event.key();
    boolean _equals_1 = Objects.equal(Integer.valueOf(_key_2), Key.Key_P);
    if (!_equals_1) {
      _and = false;
    } else {
      KeyboardModifiers _modifiers = event.modifiers();
      boolean _equals_2 = Objects.equal(_modifiers, KeyboardModifier.AltModifier);
      _and = (_equals_1 && _equals_2);
    }
    if (_and) {
      CanvasNormalWidget _self_1 = PythonUtils.<CanvasNormalWidget>self(this);
      _self_1.alternar_pausa();
    }
    boolean _and_1 = false;
    int _key_3 = event.key();
    boolean _equals_3 = Objects.equal(Integer.valueOf(_key_3), Key.Key_F);
    if (!_equals_3) {
      _and_1 = false;
    } else {
      KeyboardModifiers _modifiers_1 = event.modifiers();
      boolean _equals_4 = Objects.equal(_modifiers_1, KeyboardModifier.AltModifier);
      _and_1 = (_equals_3 && _equals_4);
    }
    if (_and_1) {
      CanvasNormalWidget _self_2 = PythonUtils.<CanvasNormalWidget>self(this);
      _self_2.alternar_pantalla_completa();
    }
    EscenaBase _eventos_1 = PilasExtensions.eventos(this);
    Evento _pulsaTecla = _eventos_1.getPulsaTecla();
    boolean _isAutoRepeat = event.isAutoRepeat();
    String _text = event.text();
    DataEventoTeclado _dataEventoTeclado = new DataEventoTeclado(codigo_de_tecla, _isAutoRepeat, _text);
    _pulsaTecla.emitir(_dataEventoTeclado);
    CanvasNormalWidget _self_3 = PythonUtils.<CanvasNormalWidget>self(this);
    String _text_1 = event.text();
    _self_3.depurador.cuando_pulsa_tecla(codigo_de_tecla, _text_1);
  }
  
  protected void keyReleaseEvent(final QKeyEvent event) {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    int _key = event.key();
    final Object codigo_de_tecla = _self._obtener_codigo_de_tecla_normalizado(_key);
    EscenaBase _eventos = PilasExtensions.eventos(this);
    Evento _sueltaTecla = _eventos.getSueltaTecla();
    boolean _isAutoRepeat = event.isAutoRepeat();
    String _text = event.text();
    DataEventoTeclado _dataEventoTeclado = new DataEventoTeclado(codigo_de_tecla, _isAutoRepeat, _text);
    _sueltaTecla.emitir(_dataEventoTeclado);
  }
  
  protected void wheelEvent(final QWheelEvent e) {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    EscenaBase _escenaActual = _self.gestorEscenas.escenaActual();
    Evento _mueveRueda = _escenaActual.getMueveRueda();
    int _delta = e.delta();
    int _divide = (_delta / 120);
    DataEventoRuedaMouse _dataEventoRuedaMouse = new DataEventoRuedaMouse(_divide);
    _mueveRueda.emitir(_dataEventoRuedaMouse);
  }
  
  protected void mousePressEvent(final QMouseEvent e) {
    EscenaBase _escenaActual = this.gestorEscenas.escenaActual();
    Evento _clickDeMouse = _escenaActual.getClickDeMouse();
    this.triggerearEventoDeMouseClick(e, _clickDeMouse);
  }
  
  protected void mouseReleaseEvent(final QMouseEvent e) {
    EscenaBase _escenaActual = this.gestorEscenas.escenaActual();
    Evento _terminaClick = _escenaActual.getTerminaClick();
    this.triggerearEventoDeMouseClick(e, _terminaClick);
  }
  
  protected void triggerearEventoDeMouseClick(final QMouseEvent e, final Evento evento) {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    final float escala = _self.escala;
    QPoint _pos = e.pos();
    int _x = _pos.x();
    float _divide = (_x / escala);
    QPoint _pos_1 = e.pos();
    int _y = _pos_1.y();
    float _divide_1 = (_y / escala);
    Pair<Float,Float> _convertirDePosicionFisicaRelativa = Utils.convertirDePosicionFisicaRelativa(_divide, _divide_1);
    final Pair<Float,Float> posRelativa = PilasExtensions.relativaALaCamara(_convertirDePosicionFisicaRelativa);
    Float x = posRelativa.getKey();
    Float y = posRelativa.getValue();
    MouseButton _button = e.button();
    DataEventoMouse _dataEventoMouse = new DataEventoMouse(x, y, Float.valueOf(0f), Float.valueOf(0f), _button);
    evento.emitir(_dataEventoMouse);
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
        final HandlerEvento<DataEventoTeclado> _function = new HandlerEvento<DataEventoTeclado>() {
            public void manejar(final DataEventoTeclado data) {
              CanvasNormalWidget.this.avanzar_un_solo_cuadro_de_animacion(data);
            }
          };
        HandlerEvento _conectar = _pulsaTecla_1.conectar("tecla_en_pausa", _function);
        _xblockexpression = (_conectar);
      }
      _xifexpression = _xblockexpression;
    }
    return _xifexpression;
  }
  
  public void avanzar_un_solo_cuadro_de_animacion(final DataEventoTeclado data) {
    CanvasNormalWidget _self = PythonUtils.<CanvasNormalWidget>self(this);
    _self.actualizarEventosYActores();
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
