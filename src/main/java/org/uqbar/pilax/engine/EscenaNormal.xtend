package org.uqbar.pilax.engine

import java.util.List
import org.uqbar.pilax.eventos.DataEventoTeclado
import org.uqbar.pilax.eventos.Evento
import org.uqbar.pilax.fisica.FisicaDeshabilitada
import org.uqbar.pilax.interpolacion.tweener.Tweener

abstract class EscenaBase {
	@Property boolean iniciada
	@Property List<Actor> actores = newArrayList
	@Property Fondo fondo
	@Property Camara camara
	@Property Evento mueveCamara
	@Property Evento mueveMouse
	@Property Evento clickDeMouse
	@Property Evento terminaClick
	@Property Evento mueveRueda
	@Property Evento<DataEventoTeclado> pulsaTecla
	@Property Evento<DataEventoTeclado> sueltaTecla
	@Property Evento pulsaTeclaEscape
	@Property Evento actualizar
	@Property Evento log
	@Property Control control
	@Property Tareas tareas
	Colisiones colisiones
	@Property Tweener tweener
	FisicaDeshabilitada fisica
	
	new() {
        // Camara de la escena.
        camara = new Camara(this)
		crearEventos
        control = new Control(this)
        tareas = new Tareas
        colisiones = new Colisiones
        // Generador de interpolaciones
        tweener = new Tweener
        fisica = Pilas.instance.mundo.crearMotorFisica
        iniciada = false
	}
	def protected crearEventos() {
		// Eventos asociados a la escena.
        mueveCamara = new Evento('mueve_camara')               // ['x', 'y', 'dx', 'dy']
        mueveMouse = new Evento('mueve_mouse')                 // ['x', 'y', 'dx', 'dy']
        clickDeMouse = new Evento('click_de_mouse')           // ['button', 'x', 'y']
        terminaClick = new Evento('termina_click')             // ['button', 'x', 'y']
        mueveRueda = new Evento('mueve_rueda')                 // ['delta']
        pulsaTecla = new Evento('pulsa_tecla')                 // ['codigo', 'texto']
        sueltaTecla = new Evento('suelta_tecla')               // ['codigo', 'texto']
        pulsaTeclaEscape = new Evento('pulsa_tecla_escape')   // []
        actualizar = new Evento('actualizar')                   // []
        log = new Evento('log')                                 // ['data']
	}
	
	
	def void iniciar()
	
	def void pausar() {}
	
	def void reanudar() {}
	
	def void agregarActor(Actor actor) {
		actor.escena = this
		actores.add(actor)
	}
	
	def void actualizarEventos() {
		tweener.update(16)
        tareas.actualizar(1 / 60.0f)
        colisiones.verificarColisiones()
	}
	
	def actualizarFisica() {
		//TODO PILAX BOX2D
//        if (fisica)
//            // Solo actualizamos la fisica si existen más de 4 bodies.
//            // Ya que las paredes ya vienen definidas al crear la fisica.
//            if (self.fisica.mundo.bodies.size > 4)
//                self.fisica.actualizar()
	}
	
	def limpiar() {
		actores.forEach[destruir]
        tareas.eliminarTodas()
        tweener.eliminarTodas()
        //TODO PILAX
//        if self.fisica:
//            self.fisica.reiniciar()
	}
	
}

class EscenaNormal extends EscenaBase {
	
	override iniciar() {
		fondo = new FondoPlano
	}
	
}