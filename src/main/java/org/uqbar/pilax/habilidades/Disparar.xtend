package org.uqbar.pilax.habilidades

import java.util.List
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Habilidad

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*
import org.uqbar.pilax.habilidades.disparar.Municion
import org.uqbar.pilax.habilidades.disparar.Bala
import org.uqbar.pilax.engine.PilaxException
import org.eclipse.xtext.xbase.lib.Procedures.Procedure0
import org.uqbar.pilax.engine.Pilas
import org.eclipse.xtext.xbase.lib.Procedures.Procedure2

class Disparar extends Habilidad {
	Class municion = Bala
	int frecuenciaDeDisparo = 10
	@Property List<Actor> enemigos = newArrayList
	int anguloSalidaDisparos = 0
	@Property double offsetDisparos = 0
	Pair<Double,Double> offsetOrigenAutor = origen
	Procedure0 cuandoDispara
	double escala = 1
	Procedure2<Actor, Actor> cuando_elimina_enemigo
	
	List<Actor> proyectiles = newArrayList
	int contador_frecuencia_disparo = 0
	
	new(Actor receptor) {
		super(receptor)
	}
	
	def void setEnemigos(List<Actor> enemigos) {
        this.enemigos = enemigos
        pilas.escenaActual.colisiones.agregar(proyectiles, enemigos, cuando_elimina_enemigo)
	}
	
	override actualizar() {
        contador_frecuencia_disparo = contador_frecuencia_disparo + 1

        if (pulsa_disparar)
            if (contador_frecuencia_disparo > frecuenciaDeDisparo) {
                contador_frecuencia_disparo = 0
                disparar
            }
        _eliminar_disparos_innecesarios
	}
	
    def _agregar_disparo(Actor proyectil) {
        proyectil.escala = escala
        proyectiles.add(proyectil)
    }

    def _eliminar_disparos_innecesarios() {
        for (d : proyectiles.copy) {
            if (d.estaFueraDeLaPantalla) {
                d.eliminar
                proyectiles.remove(d)
            }
        }
	}
	
    def disparar() {
    	val offsetAut = if (receptor.espejado) -offsetOrigenAutor.x else offsetOrigenAutor.x

		val puntoOrigen = receptor.getPuntoADistanciaSobreRectaRotacion(offsetDisparos)
		
        if (issubclass(municion, Municion)) {
//            val objeto_a_disparar = municion.newInstanceWith(parametros_municion) as Municion
            val objeto_a_disparar = municion.newInstance as Municion

            objeto_a_disparar.disparar(puntoOrigen.x, puntoOrigen.y,
                                   receptor.rotacion - 90,
                                   receptor.rotacion + -(anguloSalidaDisparos),
                                   0,
                                   0)

            for (disparo : objeto_a_disparar.proyectiles) {
                _agregar_disparo(disparo)
                disparo.fijo = receptor.fijo
			}
		}
        else if (issubclass(municion, Actor)) {
        	
        	val objeto_a_disparar = municion.newInstanceWith(puntoOrigen.x, puntoOrigen.y,
                                              receptor.rotacion - 90,
                                              receptor.rotacion + -(anguloSalidaDisparos))

            _agregar_disparo(objeto_a_disparar)
            objeto_a_disparar.fijo = receptor.fijo
        }
        else
            throw new PilaxException("No se puede disparar este objeto.")

        if (cuandoDispara != null)
            cuandoDispara.apply
	}

    def pulsa_disparar() {
        return Pilas.instance.escenaActual.control.boton
	}
	
}