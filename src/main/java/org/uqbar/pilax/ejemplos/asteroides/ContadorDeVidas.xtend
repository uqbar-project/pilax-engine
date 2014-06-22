package org.uqbar.pilax.ejemplos.asteroides

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*
import org.uqbar.pilax.engine.Actor
import java.util.List
import com.google.common.collect.Lists
import org.uqbar.pilax.actores.ActorTexto
import java.awt.Color

class ContadorDeVidas {
	List<Actor> vidas
	int cantidadDeVidas
	
	ActorTexto texto
	
	new(int cantidadDeVidas) {
		crear_texto()
        this.cantidadDeVidas = cantidadDeVidas
        vidas = Lists.newArrayList(range(cantidadDeVidas).map[ new Actor("data/vida.png", 0,0)])
        
       	var indice = 0
        for (vida : vidas) {
            vida.x = -210 + indice * 30
            vida.arriba = 220
            indice = indice + 1
        }
	}
	
	def crear_texto() {
        texto = new ActorTexto("Vidas:")
        texto.color = Color.white
        texto.magnitud = 20
        texto.izquierda = -310
        texto.arriba = 220
    }

    def isLeQuedanVidas() {
        return cantidadDeVidas > 0
    }

    def quitarUnaVida() {
        cantidadDeVidas = cantidadDeVidas - 1
        val vida = vidas.pop
        vida.eliminar
	}
}