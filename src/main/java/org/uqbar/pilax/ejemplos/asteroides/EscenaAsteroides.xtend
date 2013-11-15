package org.uqbar.pilax.ejemplos.asteroides

import java.awt.Color
import java.util.List
import org.uqbar.pilax.actores.ActorPuntaje
import org.uqbar.pilax.actores.animacion.ActorNave
import org.uqbar.pilax.engine.EscenaBase
import org.uqbar.pilax.engine.FondoEspacio
import org.uqbar.pilax.engine.Tamanio
import org.uqbar.pilax.habilidades.SeMantieneEnPantalla

import static org.uqbar.pilax.utils.PythonUtils.*
import org.uqbar.pilax.engine.Pilas

class EscenaAsteroides extends EscenaBase {
	ActorPuntaje puntaje
	List<PiedraEspacial> piedras
	Estado estado
	ActorNave nave
	@Property ContadorDeVidas contadorDeVidas
	
	override iniciar() {
		new FondoEspacio
        pulsaTeclaEscape.conectar([d| pulsaEscape])
        piedras = newArrayList
        crearNave
        crearContadorDeVidas
        cambiarEstado(new Iniciando(this, 1))
        puntaje = new ActorPuntaje(280, 220) => [ color = Color.white ]
	}
	
	def cambiarEstado(Estado estado) {
        this.estado = estado
    }

    def crearNave() {
        nave = new ActorNave(0, 0, 2)
        nave.aprender(SeMantieneEnPantalla)
//        nave.definir_enemigos(piedras, [|cuando_explota_asterioide])
        colisiones.agregar(nave, piedras, [n,p| explotar_y_terminar(n,p)])
	}
	
    def cuando_explota_asterioide() {
        puntaje.aumentar(1)
	}
	
    def crearContadorDeVidas() {
        contadorDeVidas = new ContadorDeVidas(3)
    }

    def pulsaEscape() {
        Pilas.instance.cambiarEscena(new EscenaMenu)
	}
	
    def explotar_y_terminar(ActorNave nave, PiedraEspacial piedra) {
        /* Responde a la colision entre la nave y una piedra.*/
        nave.eliminar
        cambiarEstado(new PierdeVida(this))
	}
	
    def crear_naves(int cantidad) {
        /**Genera una cantidad especifica de naves en el escenario.*/
        val fuera_de_la_pantalla = #[-600, -650, -700, -750, -800]
        val tamanos = #[Tamanio.grande, Tamanio.media, Tamanio.chica]

        for (i : range(cantidad)) {
            val x = choice(fuera_de_la_pantalla)
            val y = choice(fuera_de_la_pantalla)
            val t = choice(tamanos)

            piedras.add(new PiedraEspacial(piedras, x, y, t))
        }
	}
	
    def ha_eliminado_todas_las_piedras() {
        return piedras.empty
    }
	
}