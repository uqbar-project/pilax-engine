package org.uqbar.pilax.ejemplos.asteroides

import java.util.List
import org.uqbar.pilax.actores.ActorPuntaje
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.EscenaBase
import org.uqbar.pilax.engine.Pilas

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*
import java.awt.Color
import org.uqbar.pilax.engine.FondoEspacio
import org.uqbar.pilax.actores.animacion.ActorNave
import org.uqbar.pilax.engine.Tamanio

class EscenaAsteroides extends EscenaBase {
	ActorPuntaje puntaje
	List<PiedraEspacial> piedras
	Estado estado
	ActorNave nave
	@Property ContadorDeVidas contador_de_vidas
	
	override iniciar() {
		new FondoEspacio
        pulsaTeclaEscape.conectar("", [d| cuando_pulsa_tecla_escape])
        piedras = newArrayList
        crear_nave
        crear_contador_de_vidas
        cambiar_estado(new Iniciando(this, 1))
        puntaje = new ActorPuntaje(280, 220) => [ color = Color.white ]
	}
	
	def cambiar_estado(Estado estado) {
        this.estado = estado
    }

    def crear_nave() {
        nave = new ActorNave(0, 0, 2)
//        nave.aprender(SeMantieneEnPantalla)
//        nave.definir_enemigos(self.piedras, self.cuando_explota_asterioide)
        colisiones.agregar(nave, piedras, [n,p| explotar_y_terminar(n,p)])
	}
	
    def cuando_explota_asterioide() {
        puntaje.aumentar(1)
	}
	
    def crear_contador_de_vidas() {
        contador_de_vidas = new ContadorDeVidas(3)
    }

    def cuando_pulsa_tecla_escape() {
        /**Regresa al menu principal.*/
//        pilas.cambiarEscena(escena_menu.EscenaMenu())
	}
	
    def explotar_y_terminar(ActorNave nave, PiedraEspacial piedra) {
        /* Responde a la colision entre la nave y una piedra.*/
        nave.eliminar
        cambiar_estado(new PierdeVida(this))
	}
	
    def crear_naves(int cantidad) {
        /**Genera una cantidad especifica de naves en el escenario.*/
        val fuera_de_la_pantalla = #[-600, -650, -700, -750, -800]
        val tamanos = #[Tamanio.grande, Tamanio.media, Tamanio.chica]

        for (i : range(cantidad)) {
            val x = choice(fuera_de_la_pantalla)
            val y = choice(fuera_de_la_pantalla)
            val t = choice(tamanos)

            piedras.add(new PiedraEspacial(piedras, x.intValue, y.intValue, t))
        }
	}
	
    def ha_eliminado_todas_las_piedras() {
        return len(self.piedras) == 0
    }
	
}