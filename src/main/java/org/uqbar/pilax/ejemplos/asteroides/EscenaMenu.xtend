package org.uqbar.pilax.ejemplos.asteroides

import java.util.Map
import org.eclipse.xtext.xbase.lib.Procedures.Procedure0
import org.uqbar.pilax.actores.interfaz.Menu
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.EscenaBase
import org.uqbar.pilax.engine.Fondo
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.engine.Tamanio

import static org.uqbar.pilax.utils.PythonUtils.*
import static org.uqbar.pilax.utils.Utils.*

import static extension org.uqbar.pilax.utils.PilasExtensions.*

class EscenaMenu extends EscenaBase {
	Actor logotipo
	Menu menu
	
	override iniciar() {
		new Fondo("data/menu.png")
        crearTituloDelJuego
        Pilas.instance.avisar("Use el teclado para controlar el menu.")
        crearElMenuPrincipal
        crearAsteroides
	}
	
	def crearTituloDelJuego() {
        logotipo = new Actor("data/titulo.png", 0, 300)
        interpolar(logotipo, "y", #[200])
    }

    def crearElMenuPrincipal() { 
        val Map<String,Procedure0> opciones = newHashMap(
        		"Comenzar a jugar" -> [| comenzarAJugar], 
        		"Ver ayuda" -> [| mostrarAyudaDelJuego], 
        		"Salir" -> [| salirDelJuego])
        menu = new Menu(opciones, 0, -50)
	}

    def void comenzarAJugar() {
        cambiarEscenaActual(new EscenaAsteroides)
    }

    def void mostrarAyudaDelJuego() {
//        pilas.cambiarEscena(escena_ayuda.Ayuda())
    }

    def void salirDelJuego() {
        pilas.terminar
    }

    def crearAsteroides() {
        val fueraDeLaPantalla = #[-600, -650, -700, -750, -800]
        for (n : range(5)) {
            val x = choice(fueraDeLaPantalla)
            val y = choice(fueraDeLaPantalla)
            new PiedraEspacial(newArrayList, x, y, Tamanio.chica)
        }
    }
	
}