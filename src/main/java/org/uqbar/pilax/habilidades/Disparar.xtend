package org.uqbar.pilax.habilidades

import java.util.List
import org.eclipse.xtext.xbase.lib.Pair
import org.eclipse.xtext.xbase.lib.Procedures.Procedure0
import org.eclipse.xtext.xbase.lib.Procedures.Procedure2
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Habilidad
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.engine.PilaxException
import org.uqbar.pilax.habilidades.disparar.Bala
import org.uqbar.pilax.habilidades.disparar.Municion

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

// TODO: 1) agregar generics para manejar la colision
//  2) rediseñar el hecho de que puede trabajar configurandole la clase del Actor a disparar
//  	o bien una Municion que es la que realmente dispara (pero ahora todo se dice de la misma forma
//			con un Class) 
class Disparar extends Habilidad {
	Class municion = Bala
	@Property List<Actor> enemigos = newArrayList
	@Property double offsetDisparos = 0

	int frecuenciaDeDisparo = 10
	int anguloSalidaDisparos = 0
	Procedure0 cuandoDispara
	double escala = 1
	(Actor, Actor) => void cuando_elimina_enemigo
	List<Actor> proyectiles = newArrayList
	int contadorFrecuenciaDisparo = 0
	
	new(Actor receptor) {
		super(receptor)
	}
	
	def void setEnemigos(List<Actor> enemigos) {
        definirColision(enemigos, cuando_elimina_enemigo)
	}
	
	def definirColision(List grupo_enemigos, (Actor,Actor) => void cuando_elimina_enemigo) {
        _enemigos = grupo_enemigos
        pilas.escenaActual.colisiones.agregar(proyectiles, enemigos, cuando_elimina_enemigo)
	}
	
	override actualizar() {
        contadorFrecuenciaDisparo = contadorFrecuenciaDisparo + 1

        if (pulsaDisparar)
            if (contadorFrecuenciaDisparo > frecuenciaDeDisparo) {
                contadorFrecuenciaDisparo = 0
                disparar
            }
        eliminarDisparosInnecesarios
	}
	
    def agregarDisparo(Actor proyectil) {
        proyectil.escala = escala
        proyectiles.add(proyectil)
    }

    def eliminarDisparosInnecesarios() {
        for (p : proyectiles.copy) {
            if (p.estaFueraDeLaPantalla) {
                p.eliminar
                proyectiles.remove(p)
            }
        }
	}
	
    def disparar() {
		val puntoOrigen = receptor.getPuntoADistanciaSobreRectaRotacion(offsetDisparos)
		
        if (issubclass(municion, Municion)) {
//            val municion = municion.newInstanceWith(parametros_municion) as Municion
            val municion = municion.newInstance as Municion

            municion.disparar(puntoOrigen.x, puntoOrigen.y,
                                   receptor.rotacion - 90,
                                   receptor.rotacion + -(anguloSalidaDisparos),
                                   0,
                                   0)

            for (disparo : municion.proyectiles) {
                agregarDisparo(disparo)
                disparo.fijo = receptor.fijo
			}
		}
        else if (issubclass(municion, Actor)) {
        	val proyectil = municion.newInstanceWith(puntoOrigen.x, puntoOrigen.y,
                                              receptor.rotacion - 90,
                                              receptor.rotacion + -(anguloSalidaDisparos))

            agregarDisparo(proyectil)
            proyectil.fijo = receptor.fijo
        }
        else
            throw new PilaxException("No se puede disparar este objeto.")

        if (cuandoDispara != null)
            cuandoDispara.apply
	}

    def pulsaDisparar() {
        return Pilas.instance.escenaActual.control.boton
	}
	
}