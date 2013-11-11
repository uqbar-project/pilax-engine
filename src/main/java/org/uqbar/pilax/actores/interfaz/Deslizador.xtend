package org.uqbar.pilax.actores.interfaz

import java.util.List
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1
import org.uqbar.pilax.actores.PosicionCentro
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.eventos.DataEventoMouse

import static extension org.uqbar.pilax.utils.PythonUtils.*
import org.uqbar.pilax.eventos.DataEvento

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class Deslizador extends ActorBaseInterfaz {
	Actor deslizador
	boolean click
	double progreso
	int posicion_relativa_x
	
	List<Procedure1<Double>> funciones
	
	double limite_izq
	
	double limite_der
	
	new() {
		this(0, 0, "interfaz/barra.png", "interfaz/deslizador.png")
	}

    /** Inicializa al actor.

        :param x: Posición horizontal inicial.
        :param y: Posición vertical inicial.
        :param ruta_barra: Imagen que se usará como barra.
        :param ruta_deslizador: Imagen para presentar al manejado o cursor del deslizador.
     */	
	new(int x, int y, String ruta_barra, String ruta_deslizador) {
		super(ruta_barra, x, y)
        deslizador = null
        deslizador = new Actor(ruta_deslizador, x, y)
        deslizador.fijo = true
        centroRelativo = (PosicionCentro.IZQUIERDA -> PosicionCentro.CENTRO)

        click = false

        escena.clickDeMouse.conectar(id + "click", [d| click_del_mouse(d)])
        escena.mueveMouse.conectar(id + "muevemouse", [d| movimiento_del_mouse(d)])
        escena.terminaClick.conectar(id + "terminaClick", [d| termino_del_click(d)])

        progreso = 0
        posicion_relativa_x = 0

        funciones = newArrayList

        // establecemos posicion inicial
        this.x = x
        this.y = y
        fijo = true
	}
	
	def click_del_mouse(DataEventoMouse d) {
        if (activo)
            if (deslizador.colisionaConPunto(d.posicion))
                click = true
	}
	
	def movimiento_del_mouse(DataEventoMouse movimiento) {
        if (activo) {
            if (click) {
                val ancho = self.ancho
                val deslizador_pos_x = self.deslizador.x - self.x
                val factor = (deslizador_pos_x + ancho) / ancho - 1
                progreso = factor

                ejecutar_funciones(factor)

                deslizador.x = movimiento.posicion.x.doubleValue

                if (deslizador.x <= limite_izq)
                    deslizador.x = limite_izq
                else if (deslizador.x >= limite_der)
                    deslizador.x = limite_der

                posicion_relativa_x = (deslizador.x - x).intValue
            }
        }
    }

	def ejecutar_funciones(double valor) {
        funciones.forEach[f| f.apply(valor)]
	}
	
    /** Cambia la posición.
      :param x: Nueva posición horizontal.
      :param y: Nueva posición vertical.
     */    
    override setPosicion(int x, int y) {
        this.x = x
        this.y = y
    }
    
	override setX(double x) {
		limite_izq = this.x
        limite_der = this.x + ancho
		super.setX(x)
		deslizador.x = x + posicion_relativa_x
	}
	
	override setY(double y) {
		super.setY(y)
		deslizador.y = y - (alto / 2)
	}
    
    def termino_del_click(DataEvento noclick) {
        click = false
    }
    
	override mostrar() {
		super.mostrar
		deslizador.transparencia = 0
	}
    
	override ocultar() {
		super.ocultar
		deslizador.transparencia = 100
	}
	
	override eliminar() {
		deslizador.eliminar
		super.eliminar
	}
	
	def void conectar(Procedure1<Double> f) {
        funciones.add(f)
    }

}