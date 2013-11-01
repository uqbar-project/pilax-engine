package org.uqbar.pilax.engine

import java.util.List

import static extension org.uqbar.pilax.engine.PythonUtils.*

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
	@Property Evento pulsaTecla
	@Property Evento sueltaTecla
	@Property Evento pulsaTeclaEscape
	@Property Evento actualizar
	@Property Evento log
	Control control
	Tareas tareas
	Colisiones colisiones
	Tweener tweener
	FisicaDeshabilitada fisica
	
	new() {
        // Camara de la escena.
        self.camara = new Camara(this)

        // Eventos asociados a la escena.
        self.mueveCamara = new Evento('mueve_camara')               // ['x', 'y', 'dx', 'dy']
        self.mueveMouse = new Evento('mueve_mouse')                 // ['x', 'y', 'dx', 'dy']
        self.clickDeMouse = new Evento('click_de_mouse')           // ['button', 'x', 'y']
        self.terminaClick = new Evento('termina_click')             // ['button', 'x', 'y']
        self.mueveRueda = new Evento('mueve_rueda')                 // ['delta']
        self.pulsaTecla = new Evento('pulsa_tecla')                 // ['codigo', 'texto']
        self.sueltaTecla = new Evento('suelta_tecla')               // ['codigo', 'texto']
        self.pulsaTeclaEscape = new Evento('pulsa_tecla_escape')   // []
        self.actualizar = new Evento('actualizar')                   // []
        self.log = new Evento('log')                                 // ['data']

        self.control = new Control(this, null)

        // Gestor de tareas
        self.tareas = new Tareas

        // Gestor de colisiones
        self.colisiones = new Colisiones

        // Generador de interpolaciones
        self.tweener = new Tweener

        // Administrador de la fisica de la escena.
        self.fisica = Pilas.instance.mundo.crearMotorFisica

        // Control para saber si se ha iniciado la escena y poder actualizarla.
        self.iniciada = false
	}
	
	
	def void iniciar()
	
	def void pausar() {}
	
	def void reanudar() {}
	
	def void agregarActor(Actor actor) {
		actor.escena = this
		actores.add(actor)
	}
	
	def void actualizarEventos() {
//		self.tweener.update(16)
        self.tareas.actualizar(1 / 60.0f)
        self.colisiones.verificarColisiones()
	}
	
	def actualizarFisica() {
		//TODO PILAX BOX2D
//        if (self.fisica)
//            // Solo actualizamos la fisica si existen más de 4 bodies.
//            // Ya que las paredes ya vienen definidas al crear la fisica.
//            if (self.fisica.mundo.bodies.size > 4)
//                self.fisica.actualizar()
	}
	
	def limpiar() {
		self.actores.forEach[destruir]

        self.tareas.eliminar_todas()
        //TODO PILAX
//        self.tweener.eliminar_todas()
//        if self.fisica:
//            self.fisica.reiniciar()
	}
	
}

class EscenaNormal extends EscenaBase {
	
	override iniciar() {
		fondo = new FondoPlano
	}
	
}