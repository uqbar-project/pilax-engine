package org.uqbar.pilax.ejemplos.asteroides

import org.uqbar.pilax.engine.EscenaBase
import org.uqbar.pilax.engine.Fondo
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.engine.Actor

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*
import static extension org.uqbar.pilax.utils.Utils.*

import org.uqbar.pilax.actores.interfaz.Menu
import org.uqbar.pilax.engine.Tamanio
import org.eclipse.xtext.xbase.lib.Procedures.Procedure0
import java.util.Map

class EscenaMenu extends EscenaBase {
	Actor logotipo
	Menu menu
	
	override iniciar() {
		new Fondo("data/menu.png")
        crear_titulo_del_juego
        Pilas.instance.avisar("Use el teclado para controlar el menu.")
        crear_el_menu_principal
        crear_asteroides
	}
	
	def crear_titulo_del_juego() {
        logotipo = new Actor("data/titulo.png", 0, 300)
        interpolar(logotipo, "y", #[200])
    }

    def crear_el_menu_principal() { 
        val Map<String,Procedure0> opciones = newHashMap(
        		"Comenzar a jugar" -> [| this.comenzar_a_jugar], 
        		"Ver ayuda" -> [| this.mostrar_ayuda_del_juego], 
        		"Salir" -> [| this.salir_del_juego])
        menu = new Menu(opciones, 0, -50)
	}

    def void comenzar_a_jugar() {
        pilas.cambiarEscena(new EscenaAsteroides)
    }

    def void mostrar_ayuda_del_juego() {
//        pilas.cambiarEscena(escena_ayuda.Ayuda())
    }

    def void salir_del_juego() {
        pilas.terminar
    }

    def crear_asteroides() {
        val fueraDeLaPantalla = #[-600, -650, -700, -750, -800]
        for (n : range(5)) {
            val x = choice(fueraDeLaPantalla)
            val y = choice(fueraDeLaPantalla)
            new PiedraEspacial(newArrayList, x, y, Tamanio.chica)
        }
    }
	
}