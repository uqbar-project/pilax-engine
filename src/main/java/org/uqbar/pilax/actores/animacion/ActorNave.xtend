package org.uqbar.pilax.actores.animacion

import java.util.List
import org.eclipse.xtext.xbase.lib.Procedures.Procedure0
import org.uqbar.pilax.ejemplos.asteroides.PiedraEspacial
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.habilidades.Disparar
import org.uqbar.pilax.habilidades.MoverseConTeclado
import org.uqbar.pilax.habilidades.PuedeExplotar
import org.uqbar.pilax.motor.GrillaImagen

class ActorNave extends ActorAnimacion {
	Disparar habilidadDisparar
	() => void cuandoEliminaEnemigo
	
	new(double x, double y, double velocidad) {
		super(new GrillaImagen("nave.png", 2), x, y, true)
		this.velocidad = velocidad -> velocidad
		radioDeColision = 20
		aprender(PuedeExplotar)
		
//		municion = new ActorMisil
		habilidadDisparar = aprender(Disparar) => [
            offsetDisparos = 29d
//			municion=self.municion,
//          angulo_salida_disparo=0,
//          frecuencia_de_disparo=6,
//          escala=0.7
		]
		aprender(MoverseConTeclado)	=> [
				velocidadMaxima=velocidad
            	aceleracion=1
                deceleracion=0.04
                conRotacion=true
                velocidadRotacion=1
                marchaAtras=false
		]
	}
	
	def definirEnemigos(List<PiedraEspacial> piedras, Procedure0 cuando_elimina_enemigo) {
		cuandoEliminaEnemigo = cuando_elimina_enemigo
        habilidadDisparar.definirColision(piedras, [d,e| hacer_explotar_al_enemigo(d, e)])
	}
	
    def hacer_explotar_al_enemigo(Actor mi_disparo, Actor el_enemigo) {
        mi_disparo.eliminar
        el_enemigo.eliminar
    }
}