package org.uqbar.pilax.habilidades

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Control
import org.uqbar.pilax.engine.Habilidad
import org.uqbar.pilax.eventos.DataEvento

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

/** Hace que un actor cambie de posición con pulsar el teclado.*/
class MoverseConTeclado extends Habilidad {
	static int CUATRO_DIRECCIONES = 4
	static int OCHO_DIRECCIONES = 8
	@Property int velocidadMaxima = 4
	@Property int direcciones = OCHO_DIRECCIONES
	@Property int aceleracion = 1
	@Property double deceleracion = 0.1
	@Property int velocidadRotacion = 1
	@Property boolean marchaAtras = true
	@Property boolean conRotacion = false
	Control control

	// dinamicas
	@Property double velocidad

	/**
	 * """Inicializa la habilidad.

        :param receptor: Referencia al actor que aprenderá la habilidad.
        :param control: Control al que va a responder para mover el Actor.
        :param direcciones: Establece si puede mover en cualquier direccion o unicamente en 4 direcciones arriba, abajo, izquierda y derecha. El parametro con_rotacion establece las direcciones a OCHO_DIRECCIONES siempre.
        :param velocidad_maxima: Velocidad maxima en pixeles a la que se moverá el Actor.
        :param aceleracion: Indica lo rapido que acelera el actor hasta su velocidad máxima.
        :param deceleracion: Indica lo rapido que decelera el actor hasta parar.
        :param con_rotacion: Si deseas que el actor rote pulsando las teclas de izquierda y derecha.
        :param velocidad_rotacion: Indica lo rapido que rota un actor sobre si mismo.
        :param marcha_atras: Posibilidad de ir hacia atrás. (True o False)
	 
	 */
	new(
		Actor receptor
	/* control=None, direcciones=OCHO_DIRECCIONES, velocidad_maxima=4,
                 aceleracion=1, deceleracion=0.1, con_rotacion=False, velocidad_rotacion=1, marcha_atras=True */
	) {
		super(receptor)
		pilas.escenaActual.actualizar.conectar("moverseConTeclado", [d|on_key_press(d)])
		control = receptor.escena.control
		velocidad = 0
	}

	def on_key_press(DataEvento evento) {
		if (conRotacion) 							keyPressedConRotacion
		else if (direcciones == OCHO_DIRECCIONES)	keyPressedOchoDirecciones
		else										keyPressedCuatroDirecciones
	}

	def keyPressedCuatroDirecciones() {
		if (control.izquierda)
			receptor.x = receptor.x - velocidadMaxima
		else if (control.derecha)
			receptor.x = receptor.x + velocidadMaxima
		else if (control.arriba)
			receptor.y = receptor.y + velocidadMaxima
		else if (control.abajo)
			if (marchaAtras)
				receptor.y = receptor.y - velocidadMaxima
	}

	def protected keyPressedOchoDirecciones() {
		if (control.izquierda)
			receptor.x = receptor.x - velocidadMaxima
		else if (control.derecha)
			receptor.x = receptor.x + velocidadMaxima

		if (control.arriba)
			receptor.y = receptor.y + velocidadMaxima
		else if (control.abajo && marchaAtras)
			receptor.y = receptor.y - velocidadMaxima
	}

	def protected keyPressedConRotacion() {
		if (control.izquierda)
			receptor.rotacion = receptor.rotacion - velocidadRotacion * velocidadMaxima
		else if (control.derecha)
			receptor.rotacion = receptor.rotacion + velocidadRotacion * velocidadMaxima

		if (control.arriba)
			avanzar(1)
		else if (control.abajo) {
			if (marchaAtras)
				avanzar(-1)
			else
				decelerar
		} else
			decelerar

		val rotacionEnRadianes = Math.toRadians(-receptor.rotacion + 90)
		val dx = Math.cos(rotacionEnRadianes) * velocidad
		val dy = Math.sin(rotacionEnRadianes) * velocidad
		receptor.x = receptor.x + dx
		receptor.y = receptor.y + dy
	}

	def decelerar() {
		if (velocidad > deceleracion)
			velocidad = velocidad - deceleracion
		else if (velocidad < -deceleracion)
			velocidad = velocidad + deceleracion
		else
			velocidad = 0
	}

	def avanzar(int delta) {
		velocidad = velocidad + aceleracion * delta

		if (velocidad > velocidadMaxima)
			velocidad = velocidadMaxima
		else if (velocidad < -velocidadMaxima / 2)
			velocidad = -velocidadMaxima / 2
	}

}
