package org.uqbar.pilax.engine;

import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.uqbar.pilax.engine.Actor;
import org.uqbar.pilax.engine.Camara;
import org.uqbar.pilax.engine.Colisiones;
import org.uqbar.pilax.engine.Control;
import org.uqbar.pilax.engine.Evento;
import org.uqbar.pilax.engine.FisicaDeshabilitada;
import org.uqbar.pilax.engine.Fondo;
import org.uqbar.pilax.engine.Mundo;
import org.uqbar.pilax.engine.Pilas;
import org.uqbar.pilax.engine.PythonUtils;
import org.uqbar.pilax.engine.Tareas;
import org.uqbar.pilax.engine.Tweener;

@SuppressWarnings("all")
public abstract class EscenaBase {
  private boolean _iniciada;
  
  public boolean isIniciada() {
    return this._iniciada;
  }
  
  public void setIniciada(final boolean iniciada) {
    this._iniciada = iniciada;
  }
  
  private List<Actor> _actores = new Function0<List<Actor>>() {
    public List<Actor> apply() {
      ArrayList<Actor> _newArrayList = CollectionLiterals.<Actor>newArrayList();
      return _newArrayList;
    }
  }.apply();
  
  public List<Actor> getActores() {
    return this._actores;
  }
  
  public void setActores(final List<Actor> actores) {
    this._actores = actores;
  }
  
  private Fondo _fondo;
  
  public Fondo getFondo() {
    return this._fondo;
  }
  
  public void setFondo(final Fondo fondo) {
    this._fondo = fondo;
  }
  
  private Camara _camara;
  
  public Camara getCamara() {
    return this._camara;
  }
  
  public void setCamara(final Camara camara) {
    this._camara = camara;
  }
  
  private Evento _mueveCamara;
  
  public Evento getMueveCamara() {
    return this._mueveCamara;
  }
  
  public void setMueveCamara(final Evento mueveCamara) {
    this._mueveCamara = mueveCamara;
  }
  
  private Evento _mueveMouse;
  
  public Evento getMueveMouse() {
    return this._mueveMouse;
  }
  
  public void setMueveMouse(final Evento mueveMouse) {
    this._mueveMouse = mueveMouse;
  }
  
  private Evento _clickDeMouse;
  
  public Evento getClickDeMouse() {
    return this._clickDeMouse;
  }
  
  public void setClickDeMouse(final Evento clickDeMouse) {
    this._clickDeMouse = clickDeMouse;
  }
  
  private Evento _terminaClick;
  
  public Evento getTerminaClick() {
    return this._terminaClick;
  }
  
  public void setTerminaClick(final Evento terminaClick) {
    this._terminaClick = terminaClick;
  }
  
  private Evento _mueveRueda;
  
  public Evento getMueveRueda() {
    return this._mueveRueda;
  }
  
  public void setMueveRueda(final Evento mueveRueda) {
    this._mueveRueda = mueveRueda;
  }
  
  private Evento _pulsaTecla;
  
  public Evento getPulsaTecla() {
    return this._pulsaTecla;
  }
  
  public void setPulsaTecla(final Evento pulsaTecla) {
    this._pulsaTecla = pulsaTecla;
  }
  
  private Evento _sueltaTecla;
  
  public Evento getSueltaTecla() {
    return this._sueltaTecla;
  }
  
  public void setSueltaTecla(final Evento sueltaTecla) {
    this._sueltaTecla = sueltaTecla;
  }
  
  private Evento _pulsaTeclaEscape;
  
  public Evento getPulsaTeclaEscape() {
    return this._pulsaTeclaEscape;
  }
  
  public void setPulsaTeclaEscape(final Evento pulsaTeclaEscape) {
    this._pulsaTeclaEscape = pulsaTeclaEscape;
  }
  
  private Evento _actualizar;
  
  public Evento getActualizar() {
    return this._actualizar;
  }
  
  public void setActualizar(final Evento actualizar) {
    this._actualizar = actualizar;
  }
  
  private Evento _log;
  
  public Evento getLog() {
    return this._log;
  }
  
  public void setLog(final Evento log) {
    this._log = log;
  }
  
  private Control control;
  
  private Tareas tareas;
  
  private Colisiones colisiones;
  
  private Tweener tweener;
  
  private FisicaDeshabilitada fisica;
  
  public EscenaBase() {
    EscenaBase _self = PythonUtils.<EscenaBase>self(this);
    Camara _camara = new Camara(this);
    _self.setCamara(_camara);
    EscenaBase _self_1 = PythonUtils.<EscenaBase>self(this);
    Evento _evento = new Evento("mueve_camara");
    _self_1.setMueveCamara(_evento);
    EscenaBase _self_2 = PythonUtils.<EscenaBase>self(this);
    Evento _evento_1 = new Evento("mueve_mouse");
    _self_2.setMueveMouse(_evento_1);
    EscenaBase _self_3 = PythonUtils.<EscenaBase>self(this);
    Evento _evento_2 = new Evento("click_de_mouse");
    _self_3.setClickDeMouse(_evento_2);
    EscenaBase _self_4 = PythonUtils.<EscenaBase>self(this);
    Evento _evento_3 = new Evento("termina_click");
    _self_4.setTerminaClick(_evento_3);
    EscenaBase _self_5 = PythonUtils.<EscenaBase>self(this);
    Evento _evento_4 = new Evento("mueve_rueda");
    _self_5.setMueveRueda(_evento_4);
    EscenaBase _self_6 = PythonUtils.<EscenaBase>self(this);
    Evento _evento_5 = new Evento("pulsa_tecla");
    _self_6.setPulsaTecla(_evento_5);
    EscenaBase _self_7 = PythonUtils.<EscenaBase>self(this);
    Evento _evento_6 = new Evento("suelta_tecla");
    _self_7.setSueltaTecla(_evento_6);
    EscenaBase _self_8 = PythonUtils.<EscenaBase>self(this);
    Evento _evento_7 = new Evento("pulsa_tecla_escape");
    _self_8.setPulsaTeclaEscape(_evento_7);
    EscenaBase _self_9 = PythonUtils.<EscenaBase>self(this);
    Evento _evento_8 = new Evento("actualizar");
    _self_9.setActualizar(_evento_8);
    EscenaBase _self_10 = PythonUtils.<EscenaBase>self(this);
    Evento _evento_9 = new Evento("log");
    _self_10.setLog(_evento_9);
    EscenaBase _self_11 = PythonUtils.<EscenaBase>self(this);
    Control _control = new Control(this);
    _self_11.control = _control;
    EscenaBase _self_12 = PythonUtils.<EscenaBase>self(this);
    Tareas _tareas = new Tareas();
    _self_12.tareas = _tareas;
    EscenaBase _self_13 = PythonUtils.<EscenaBase>self(this);
    Colisiones _colisiones = new Colisiones();
    _self_13.colisiones = _colisiones;
    EscenaBase _self_14 = PythonUtils.<EscenaBase>self(this);
    Tweener _tweener = new Tweener();
    _self_14.tweener = _tweener;
    EscenaBase _self_15 = PythonUtils.<EscenaBase>self(this);
    Pilas _instance = Pilas.instance();
    Mundo _mundo = _instance.getMundo();
    FisicaDeshabilitada _crearMotorFisica = _mundo.crearMotorFisica();
    _self_15.fisica = _crearMotorFisica;
    EscenaBase _self_16 = PythonUtils.<EscenaBase>self(this);
    _self_16.setIniciada(false);
  }
  
  public abstract void iniciar();
  
  public void pausar() {
  }
  
  public void reanudar() {
  }
  
  public void agregarActor(final Actor actor) {
    actor.setEscena(this);
    List<Actor> _actores = this.getActores();
    _actores.add(actor);
  }
  
  public void actualizarEventos() {
    EscenaBase _self = PythonUtils.<EscenaBase>self(this);
    float _divide = (1 / 60.0f);
    _self.tareas.actualizar(_divide);
    EscenaBase _self_1 = PythonUtils.<EscenaBase>self(this);
    _self_1.colisiones.verificarColisiones();
  }
  
  public Object actualizarFisica() {
    return null;
  }
}
