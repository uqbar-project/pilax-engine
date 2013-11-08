package org.uqbar.pilax.actores.interfaz

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.eventos.DataEventoMouse

class ActorBaseInterfaz extends Actor {
	@Property boolean tiene_el_foco
	boolean visible
	protected boolean activo
	int transparencia = 0
	
	new(int x, int y) {
		this("sin_imagen.png", x, y)
	}

        /** Inicializa al actor.

        :param imagen: Imagen inicial.
        :param x: Posición horizontal.
        :param y: Posición vertical.
        */	
	new(String imagen, int x, int y) {
		super(imagen,x, y)
        
        escena.clickDeMouse.conectar(id + "_click", [d| cuando_hace_click(d)])

        tiene_el_foco = false
        visible = true
        activo = true
	}
	
	def cuando_hace_click(DataEventoMouse d) {
		if (visible)
            if (colisiona_con_un_punto(d.x.intValue, d.y.intValue))
                tiene_el_foco = true
            else
                tiene_el_foco = false
	}
	
    /** Oculta el elemento de la interfaz.*/
	def void ocultar() {
        transparencia = 100
        visible = false
        activo = false
	}
	
    /**Muestra el elemento.*/
    def void mostrar() {
        visible = true
        activar()
	}
	
    def void activar() {
        activo = true
        transparencia = 0
	}
	
    def void desactivar() {
        activo = false
        transparencia = 50
	}
}