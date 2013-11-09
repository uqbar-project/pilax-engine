package org.uqbar.pilax.engine

import java.util.List
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.eventos.DataEventoMouse
import org.uqbar.pilax.eventos.DataEventoRuedaMouse
import org.uqbar.pilax.eventos.DataEventoTeclado
import org.uqbar.pilax.eventos.Evento
import org.uqbar.pilax.fisica.MotorFisica
import org.uqbar.pilax.interpolacion.tweener.Tweener

import static extension org.uqbar.pilax.utils.PilasExtensions.*

abstract class EscenaBase {
	@Property boolean iniciada
	@Property List<Actor> actores = newArrayList
	@Property Fondo fondo
	@Property Camara camara
	Pair<Integer,Integer> posicionAnteriorCamara
	@Property Control control
	@Property Tareas tareas
	@Property Colisiones colisiones
	@Property Tweener tweener
	@Property MotorFisica fisica
	
	// eventos
	@Property Evento mueveCamara
	@Property Evento<DataEventoMouse> mueveMouse
	@Property Evento<DataEventoMouse> clickDeMouse
	@Property Evento terminaClick
	@Property Evento<DataEventoRuedaMouse> mueveRueda
	@Property Evento<DataEventoTeclado> pulsaTecla
	@Property Evento<DataEventoTeclado> sueltaTecla
	@Property Evento pulsaTeclaEscape
	@Property Evento actualizar
	@Property Evento log
	
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
        mueveCamara = new Evento('mueve_camara')               			// ['x', 'y', 'dx', 'dy']
        mueveMouse = new Evento<DataEventoMouse>('mueve_mouse')         // ['x', 'y', 'dx', 'dy']
        clickDeMouse = new Evento<DataEventoMouse>('click_de_mouse')    // ['button', 'x', 'y']
        terminaClick = new Evento('termina_click')             			// ['button', 'x', 'y']
        mueveRueda = new Evento<DataEventoRuedaMouse>('mueve_rueda')    // ['delta']
        pulsaTecla = new Evento<DataEventoTeclado>('pulsa_tecla')       // ['codigo', 'texto']
        sueltaTecla = new Evento<DataEventoTeclado>('suelta_tecla')     // ['codigo', 'texto']
        pulsaTeclaEscape = new Evento('pulsa_tecla_escape')   			// []
        actualizar = new Evento('actualizar')                   		// []
        log = new Evento('log')                                 		// ['data']
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
		fisica.actualizar
	}
	
	def limpiar() {
		actores.forEach[destruir]
        tareas.eliminarTodas
        tweener.eliminarTodas
		fisica.reiniciar
	}
	
	/** Este método se llama cuando se cambia de escena y así poder
        recuperar la ubicación de la cámara en la escena actual
     */
	def guardar_posicion_camara() {
		posicionAnteriorCamara = camara.x -> camara.y 
    }

    def recuperar_posicion_camara() {
        camara.x = posicionAnteriorCamara.x
        camara.y = posicionAnteriorCamara.y
    }
    
    def pausar_fisica() {
        fisica.pausarMundo
    }
    
    def reanudar_fisica() {
        fisica.reanudarMundo
    }
	
}

class EscenaNormal extends EscenaBase {
	
	override iniciar() {
		fondo = new FondoPlano
	}
	
}