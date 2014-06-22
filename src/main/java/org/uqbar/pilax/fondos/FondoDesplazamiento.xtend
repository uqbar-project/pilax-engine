package org.uqbar.pilax.fondos

import java.util.List
import java.util.Map
import org.uqbar.pilax.engine.Fondo
import org.uqbar.pilax.eventos.DataEvento
import org.uqbar.pilax.eventos.DataEventoMovimiento

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Pilas

class FondoDesplazamiento extends Fondo {
	int posicion
	int posicionAnterior
	List<Actor> capas = newArrayList
	List<Actor> capasAuxiliares = newArrayList
	Map<Actor, Double> velocidades = newHashMap
	@Property boolean ciclico	
	
	new() {
		super("invisible.png")
        escena.mueveCamara.conectar("fondoDesplazamientoMueveCam", [d| cuandoMueveCamara(d)])
        ciclico = ciclico

        if (ciclico)
            capasAuxiliares = newArrayList
	}

	def cuandoMueveCamara(DataEventoMovimiento d) {
        val dx = d.delta.x
        // Hace que las capas no se desplacen naturalmente
        // como todos los actores.
        //for x in this.capas:
        //    x.x += dx

        // aplica un movimiento respetando las velocidades.
        moverCapas(dx)
	}
	
	def moverCapas(double dx) {
        for (capa : capas)
            capa.x = capa.x - (dx * this.velocidades.get(capa))

        if (this.ciclico) {
            for (capa : this.capasAuxiliares) {
                capa.x = capa.x - dx * this.velocidades.get(capa)
            }
		}
		
        // Resituar capa cuando se sale del todo de la ventana
        ancho = Pilas.instance.mundo.motor.ventana.width
        if (this.ciclico) {
            for (capa : this.capas) {
                if (capa.derecha < -ancho / 2) {
                	val a = this.capasAuxiliares.get(this.capas.indexOf(capa)) 
                    capa.izquierda = a.derecha
                }
            }
            for (capa : this.capasAuxiliares) {
                if (capa.derecha < -ancho / 2) {
                    capa.izquierda = capas.get(this.capasAuxiliares.indexOf(capa)).derecha
                }
            }
        }
	}
}