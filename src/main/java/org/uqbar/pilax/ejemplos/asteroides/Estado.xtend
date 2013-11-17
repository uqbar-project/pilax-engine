package org.uqbar.pilax.ejemplos.asteroides

import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.actores.ActorTexto
import java.awt.Color
import org.uqbar.pilax.utils.Utils

abstract class Estado {
	def boolean actualizar()
}

class Jugando extends Estado {
	int nivel
	EscenaAsteroides juego
	
	new (EscenaAsteroides juego, int nivel) {
		this.nivel = nivel
		this.juego = juego
		juego.crearAsteroides(nivel * 3)
		Pilas.instance.mundo.agregarTarea(1, [|actualizar])
	}
	
	override actualizar() {
		if (juego.haEliminadoTodasLasPiedras) {
            juego.cambiarEstado(new Iniciando(juego, nivel + 1))
            return false
        }
        true
	}
	
}
class Iniciando extends Estado {
	int nivel
	EscenaAsteroides juego
	ActorTexto texto
	int contador_de_segundos
	
	new(EscenaAsteroides juego, int nivel) {
        this.nivel = nivel
        this.juego = juego
		texto = new ActorTexto("Iniciando el nivel" + nivel)
        texto.color = Color.white
        contador_de_segundos = 0
        // Cada un segundo le avisa al estado que cuente.
        Pilas.instance.mundo.agregarTarea(1, [|actualizar])
	}
	
	override actualizar() {
		contador_de_segundos = contador_de_segundos + 1

        if (contador_de_segundos > 2) {
            juego.cambiarEstado(new Jugando(juego, nivel))
            texto.eliminar
            return false
        }

        true    // para indicarle al contador que siga trabajado.
	}
	
}

class PierdeVida extends Estado {
	int contadorDeSegundos
	EscenaAsteroides juego
	boolean seEjecuto = false
	
	new(EscenaAsteroides juego) {
		contadorDeSegundos = 0
        this.juego = juego

		juego.contadorDeVidas.quitarUnaVida
        if (juego.contadorDeVidas.leQuedanVidas)
            Pilas.instance.mundo.agregarTarea(1, [| actualizar])
        else
            juego.cambiarEstado(new PierdeTodoElJuego(juego))
	}
	
	override actualizar() {
		contadorDeSegundos = contadorDeSegundos + 1
        if (!seEjecuto && contadorDeSegundos > 2) {
        	seEjecuto = true
            juego.crearNave
            false
        }
		else {
	        true
        }
	}
	
}

class PierdeTodoElJuego extends Estado {
	ActorTexto mensaje
	
	new(EscenaAsteroides juego) {
        mensaje = new ActorTexto("Lo siento, has perdido!")
        mensaje.color = Color.white
        mensaje.abajo = 240
        Utils.interpolar(mensaje, "abajo", #[-20])
	}
	
	override actualizar() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}