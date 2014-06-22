package org.uqbar.pilax.actores.pingu

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.motor.GrillaImagen
import org.uqbar.pilax.actores.PosicionCentro
import org.uqbar.pilax.engine.Comportamiento
import java.util.List

class ActorPingu extends Actor {
	
	new(int x, int y) {
		super(new GrillaImagen("pingu.png", 10), x, y)
        cuadro = 4
        hacer(new Esperando)
        radioDeColision = 30
        centroRelativo = (PosicionCentro.CENTRO -> PosicionCentro.ABAJO)
	}
	
	override GrillaImagen getImagen() {
		super.imagen as GrillaImagen
	}
	
	def void setCuadro(int indice) {
        imagen.cuadro = indice
	}
	
	def getVelocidadMovimiento() {
		4.0
	}

}

class Esperando extends Comportamiento<ActorPingu> {
	
	override iniciar(ActorPingu receptor) {
		super.iniciar(receptor)
		receptor.cuadro = 4
	}
	
	override actualizar() {
		if (receptor.escena.control.izquierda)
            receptor.hacer(new Caminando)
        else if (receptor.escena.control.derecha)
            receptor.hacer(new Caminando)
        if (receptor.escena.control.arriba)
            receptor.hacer(new Saltando)
        false
	}
	
}

class Caminando extends Comportamiento<ActorPingu> {
	List<Integer> cuadros
	int paso
	
	override iniciar(ActorPingu receptor) {
		super.iniciar(receptor)
		cuadros = #[5, 5, 6, 6, 7, 7, 8, 8, 9, 9]
        paso = 0
	}
	
	override actualizar() {
		avanzarAnimacion

        if (receptor.escena.control.izquierda)
            receptor.x = receptor.x - receptor.velocidadMovimiento
        else if (receptor.escena.control.derecha)
            receptor.x = receptor.x + receptor.velocidadMovimiento
        else
            receptor.hacer(new Esperando)

        if (receptor.escena.control.arriba)
            receptor.hacer(new Saltando)

        false
	}
	
	def avanzarAnimacion() {
        paso = paso + 1
        if (paso >= cuadros.size)
            paso = 0
        receptor.cuadro = cuadros.get(paso)
	}
}

class Saltando extends Comportamiento<ActorPingu> {
	double dy = 10
	double origen
	
	override iniciar(ActorPingu receptor) {
		super.iniciar(receptor)
        receptor.cuadro = 0
        origen = receptor.y
	}
	
	override actualizar() {
		receptor.y = receptor.y + dy
        dy = dy - 0.3

        if (receptor.y < origen) {
            receptor.y = origen
            receptor.hacer(new Esperando)
		}
        if (receptor.escena.control.izquierda)
            receptor.x = receptor.x - receptor.velocidadMovimiento
        else if (receptor.escena.control.derecha)
            receptor.x = receptor.x + receptor.velocidadMovimiento
        false
	}
	
}