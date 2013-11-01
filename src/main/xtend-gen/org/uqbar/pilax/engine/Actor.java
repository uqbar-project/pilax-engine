package org.uqbar.pilax.engine;

import com.trolltech.qt.gui.QPainter;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Pair;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.uqbar.pilax.engine.Area;
import org.uqbar.pilax.engine.Camara;
import org.uqbar.pilax.engine.EscenaBase;
import org.uqbar.pilax.engine.Estudiante;
import org.uqbar.pilax.engine.Motor;
import org.uqbar.pilax.engine.Mundo;
import org.uqbar.pilax.engine.Pilas;
import org.uqbar.pilax.engine.PythonUtils;
import org.uqbar.pilax.engine.motor.ActorMotor;
import org.uqbar.pilax.engine.motor.ImagenMotor;

@SuppressWarnings("all")
public class Actor extends Estudiante {
  private boolean vivo = true;
  
  private List<Actor> anexados = new Function0<List<Actor>>() {
    public List<Actor> apply() {
      ArrayList<Actor> _newArrayList = CollectionLiterals.<Actor>newArrayList();
      return _newArrayList;
    }
  }.apply();
  
  private int _x;
  
  public int getX() {
    return this._x;
  }
  
  public void setX(final int x) {
    this._x = x;
  }
  
  private int _y;
  
  public int getY() {
    return this._y;
  }
  
  public void setY(final int y) {
    this._y = y;
  }
  
  private int _z = 0;
  
  public int getZ() {
    return this._z;
  }
  
  public void setZ(final int z) {
    this._z = z;
  }
  
  private ActorMotor actorMotor;
  
  private EscenaBase _escena;
  
  public EscenaBase getEscena() {
    return this._escena;
  }
  
  public void setEscena(final EscenaBase escena) {
    this._escena = escena;
  }
  
  private int transparencia = 0;
  
  private boolean espejado = false;
  
  private int _radioDeColision = 10;
  
  public int getRadioDeColision() {
    return this._radioDeColision;
  }
  
  public void setRadioDeColision(final int radioDeColision) {
    this._radioDeColision = radioDeColision;
  }
  
  private int _vx = 0;
  
  public int getVx() {
    return this._vx;
  }
  
  public void setVx(final int vx) {
    this._vx = vx;
  }
  
  private int _vy = 0;
  
  public int getVy() {
    return this._vy;
  }
  
  public void setVy(final int vy) {
    this._vy = vy;
  }
  
  private int _dx;
  
  public int getDx() {
    return this._dx;
  }
  
  public void setDx(final int dx) {
    this._dx = dx;
  }
  
  private int _dy;
  
  public int getDy() {
    return this._dy;
  }
  
  public void setDy(final int dy) {
    this._dy = dy;
  }
  
  private boolean _fijo;
  
  public boolean isFijo() {
    return this._fijo;
  }
  
  public void setFijo(final boolean fijo) {
    this._fijo = fijo;
  }
  
  private Pair<Integer,Integer> _centro = new Function0<Pair<Integer,Integer>>() {
    public Pair<Integer,Integer> apply() {
      Pair<Integer,Integer> _mappedTo = Pair.<Integer, Integer>of(Integer.valueOf(0), Integer.valueOf(0));
      return _mappedTo;
    }
  }.apply();
  
  public Pair<Integer,Integer> getCentro() {
    return this._centro;
  }
  
  public void setCentro(final Pair<Integer,Integer> centro) {
    this._centro = centro;
  }
  
  public Actor(final String imagen, final int x, final int y) {
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    Motor _motor = _mundo.getMotor();
    ActorMotor _obtenerActor = _motor.obtenerActor(imagen, x, y);
    this.actorMotor = _obtenerActor;
    this.setX(x);
    this.setY(y);
    Pilas _instance_1 = Pilas.instance();
    EscenaBase _escenaActual = _instance_1.escenaActual();
    _escenaActual.agregarActor(this);
    this.setDx(x);
    this.setDy(y);
  }
  
  public ImagenMotor getImagen() {
    ImagenMotor _imagen = this.actorMotor.getImagen();
    return _imagen;
  }
  
  public boolean esFondo() {
    return false;
  }
  
  public void eliminar() {
    this.eliminarAnexados();
    this.destruir();
  }
  
  /**
   * Elimina a un actor pero de manera inmediata.
   */
  public Boolean destruir() {
    Boolean _xblockexpression = null;
    {
      this.vivo = false;
      this.eliminarHabilidades();
      this.eliminarComportamientos();
      Boolean _xifexpression = null;
      Pilas _instance = Pilas.instance();
      EscenaBase _escenaActual = _instance.escenaActual();
      List<Actor> _actores = _escenaActual.getActores();
      boolean _contains = _actores.contains(this);
      if (_contains) {
        Pilas _instance_1 = Pilas.instance();
        EscenaBase _escenaActual_1 = _instance_1.escenaActual();
        List<Actor> _actores_1 = _escenaActual_1.getActores();
        boolean _remove = _actores_1.remove(this);
        _xifexpression = Boolean.valueOf(_remove);
      }
      _xblockexpression = (_xifexpression);
    }
    return _xblockexpression;
  }
  
  protected void eliminarAnexados() {
    final Procedure1<Actor> _function = new Procedure1<Actor>() {
        public void apply(final Actor it) {
          it.eliminar();
        }
      };
    IterableExtensions.<Actor>forEach(this.anexados, _function);
  }
  
  public void dibujar(final QPainter aplicacion) {
    this.actorMotor.dibujar(aplicacion);
  }
  
  /**
   * Indica si el actor está fuera del area visible de la pantalla.
   */
  public boolean estaFueraDeLaPantalla() {
    Actor _self = PythonUtils.<Actor>self(this);
    boolean _isFijo = _self.isFijo();
    if (_isFijo) {
      return false;
    }
    Actor _self_1 = PythonUtils.<Actor>self(this);
    EscenaBase _escena = _self_1.getEscena();
    Camara _camara = _escena.getCamara();
    final Area areaVisible = _camara.getAreaVisible();
    boolean _or = false;
    boolean _or_1 = false;
    boolean _or_2 = false;
    Actor _self_2 = PythonUtils.<Actor>self(this);
    int _derecha = _self_2.getDerecha();
    int _izquierda = areaVisible.getIzquierda();
    boolean _lessThan = (_derecha < _izquierda);
    if (_lessThan) {
      _or_2 = true;
    } else {
      Actor _self_3 = PythonUtils.<Actor>self(this);
      int _izquierda_1 = _self_3.getIzquierda();
      int _derecha_1 = areaVisible.getDerecha();
      boolean _greaterThan = (_izquierda_1 > _derecha_1);
      _or_2 = (_lessThan || _greaterThan);
    }
    if (_or_2) {
      _or_1 = true;
    } else {
      Actor _self_4 = PythonUtils.<Actor>self(this);
      int _abajo = _self_4.getAbajo();
      int _arriba = areaVisible.getArriba();
      boolean _greaterThan_1 = (_abajo > _arriba);
      _or_1 = (_or_2 || _greaterThan_1);
    }
    if (_or_1) {
      _or = true;
    } else {
      Actor _self_5 = PythonUtils.<Actor>self(this);
      int _arriba_1 = _self_5.getArriba();
      int _abajo_1 = areaVisible.getAbajo();
      boolean _lessThan_1 = (_arriba_1 < _abajo_1);
      _or = (_or_1 || _lessThan_1);
    }
    return _or;
  }
  
  public int getEscala() {
    return this.actorMotor.getEscala();
  }
  
  public int getIzquierda() {
    int _x = this.getX();
    Pair<Integer,Integer> _centro = this.getCentro();
    Integer _key = _centro.getKey();
    int _escala = this.getEscala();
    int _multiply = ((_key).intValue() * _escala);
    return (_x - _multiply);
  }
  
  public void setIzquierda(final int x) {
    Actor _self = PythonUtils.<Actor>self(this);
    Actor _self_1 = PythonUtils.<Actor>self(this);
    Pair<Integer,Integer> _centro = _self_1.getCentro();
    Integer _key = _centro.getKey();
    Actor _self_2 = PythonUtils.<Actor>self(this);
    int _escala = _self_2.getEscala();
    int _multiply = ((_key).intValue() * _escala);
    int _plus = (x + _multiply);
    _self.setX(_plus);
  }
  
  public int getDerecha() {
    Actor _self = PythonUtils.<Actor>self(this);
    int _izquierda = _self.getIzquierda();
    Actor _self_1 = PythonUtils.<Actor>self(this);
    int _ancho = _self_1.getAncho();
    Actor _self_2 = PythonUtils.<Actor>self(this);
    int _escala = _self_2.getEscala();
    int _multiply = (_ancho * _escala);
    int _plus = (_izquierda + _multiply);
    return _plus;
  }
  
  public void setDerecha(final int x) {
    Actor _self = PythonUtils.<Actor>self(this);
    Actor _self_1 = PythonUtils.<Actor>self(this);
    int _ancho = _self_1.getAncho();
    int _minus = (x - _ancho);
    _self.setIzquierda(_minus);
  }
  
  public int getAncho() {
    ImagenMotor _imagen = this.getImagen();
    int _ancho = _imagen.ancho();
    return _ancho;
  }
  
  public int getAlto() {
    ImagenMotor _imagen = this.getImagen();
    int _alto = _imagen.alto();
    return _alto;
  }
  
  public int getArriba() {
    Actor _self = PythonUtils.<Actor>self(this);
    int _y = _self.getY();
    Actor _self_1 = PythonUtils.<Actor>self(this);
    Pair<Integer,Integer> _centro = _self_1.getCentro();
    Integer _value = _centro.getValue();
    Actor _self_2 = PythonUtils.<Actor>self(this);
    int _escala = _self_2.getEscala();
    int _multiply = ((_value).intValue() * _escala);
    return (_y + _multiply);
  }
  
  public void setArriba(final int y) {
    Actor _self = PythonUtils.<Actor>self(this);
    Actor _self_1 = PythonUtils.<Actor>self(this);
    Pair<Integer,Integer> _centro = _self_1.getCentro();
    Integer _value = _centro.getValue();
    Actor _self_2 = PythonUtils.<Actor>self(this);
    int _escala = _self_2.getEscala();
    int _multiply = ((_value).intValue() * _escala);
    int _minus = (y - _multiply);
    _self.setY(_minus);
  }
  
  public void setAbajo(final int y) {
    Actor _self = PythonUtils.<Actor>self(this);
    Actor _self_1 = PythonUtils.<Actor>self(this);
    int _alto = _self_1.getAlto();
    int _plus = (y + _alto);
    _self.setArriba(_plus);
  }
  
  public int getAbajo() {
    Actor _self = PythonUtils.<Actor>self(this);
    int _arriba = _self.getArriba();
    Actor _self_1 = PythonUtils.<Actor>self(this);
    int _alto = _self_1.getAlto();
    Actor _self_2 = PythonUtils.<Actor>self(this);
    int _escala = _self_2.getEscala();
    int _multiply = (_alto * _escala);
    return (_arriba - _multiply);
  }
  
  /**
   * Actualiza comportamiento y habilidades antes de la actualización.
   * También actualiza la velocidad horizontal y vertical que lleva el actor.
   */
  public int preActualizar() {
    int _xblockexpression = (int) 0;
    {
      Actor _self = PythonUtils.<Actor>self(this);
      _self.actualizarComportamientos();
      Actor _self_1 = PythonUtils.<Actor>self(this);
      _self_1.actualizarHabilidades();
      Actor _self_2 = PythonUtils.<Actor>self(this);
      int _actualizarVelocidad = _self_2.actualizarVelocidad();
      _xblockexpression = (_actualizarVelocidad);
    }
    return _xblockexpression;
  }
  
  public void actualizar() {
    PythonUtils.pass(this);
  }
  
  /**
   * """ Calcula la velocidad horizontal y vertical del actor. """
   */
  protected int actualizarVelocidad() {
    int _xblockexpression = (int) 0;
    {
      Actor _self = PythonUtils.<Actor>self(this);
      int _dx = _self.getDx();
      Actor _self_1 = PythonUtils.<Actor>self(this);
      int _x = _self_1.getX();
      boolean _notEquals = (_dx != _x);
      if (_notEquals) {
        Actor _self_2 = PythonUtils.<Actor>self(this);
        Actor _self_3 = PythonUtils.<Actor>self(this);
        Actor _self_4 = PythonUtils.<Actor>self(this);
        int _x_1 = _self_4.getX();
        int _minus = (_self_3._dx - _x_1);
        int _abs = Math.abs(_minus);
        _self_2._vx = _abs;
        Actor _self_5 = PythonUtils.<Actor>self(this);
        Actor _self_6 = PythonUtils.<Actor>self(this);
        int _x_2 = _self_6.getX();
        _self_5._dx = _x_2;
      } else {
        Actor _self_7 = PythonUtils.<Actor>self(this);
        _self_7._vx = 0;
      }
      int _xifexpression = (int) 0;
      Actor _self_8 = PythonUtils.<Actor>self(this);
      Actor _self_9 = PythonUtils.<Actor>self(this);
      int _y = _self_9.getY();
      boolean _notEquals_1 = (_self_8._dy != _y);
      if (_notEquals_1) {
        int _xblockexpression_1 = (int) 0;
        {
          Actor _self_10 = PythonUtils.<Actor>self(this);
          Actor _self_11 = PythonUtils.<Actor>self(this);
          Actor _self_12 = PythonUtils.<Actor>self(this);
          int _y_1 = _self_12.getY();
          int _minus_1 = (_self_11._dy - _y_1);
          int _abs_1 = Math.abs(_minus_1);
          _self_10._vy = _abs_1;
          Actor _self_13 = PythonUtils.<Actor>self(this);
          Actor _self_14 = PythonUtils.<Actor>self(this);
          int _y_2 = _self_14.getY();
          int __dy = _self_13._dy = _y_2;
          _xblockexpression_1 = (__dy);
        }
        _xifexpression = _xblockexpression_1;
      } else {
        Actor _self_10 = PythonUtils.<Actor>self(this);
        int __vy = _self_10._vy = 0;
        _xifexpression = __vy;
      }
      _xblockexpression = (_xifexpression);
    }
    return _xblockexpression;
  }
}
