package org.uqbar.pilax.actores.animacion

import org.uqbar.pilax.actores.animacion.ActorAnimacion
import org.uqbar.pilax.motor.GrillaImagen
import org.uqbar.pilax.habilidades.PuedeExplotar
import org.uqbar.pilax.habilidades.MoverseConTeclado
import org.uqbar.pilax.habilidades.Disparar

class ActorNave extends ActorAnimacion {
	
	new(double x, double y, double velocidad) {
		super(new GrillaImagen("nave.png", 2), x, y, true)
		this.velocidad = velocidad -> velocidad
		radioDeColision = 20
		aprender(PuedeExplotar)
		
//		municion = new ActorMisil
		aprender(Disparar) => [
//			municion=self.municion,
//                       angulo_salida_disparo=0,
//                       frecuencia_de_disparo=6,
//                       offset_disparo=(29,29),
//                       escala=0.7
		]
		aprender(MoverseConTeclado) 
		=> [
				velocidadMaxima=velocidad
            	aceleracion=1
                deceleracion=0.04
                conRotacion=true
                velocidadRotacion=1
                marchaAtras=false
		]
	}
	
//	    def definir_enemigos(self, grupo, cuando_elimina_enemigo=None):
//        """Hace que una nave tenga como enemigos a todos los actores del grupo.
//
//        :param grupo: El grupo de actores que serán sus enemigos.
//        :type grupo: array
//        :param cuando_elimina_enemigo: Funcion que se ejecutará cuando se elimine un enemigo.
//
//        """
//        self.cuando_elimina_enemigo = cuando_elimina_enemigo
//        self.habilidades.Disparar.definir_colision(grupo, self.hacer_explotar_al_enemigo)
//
//    def hacer_explotar_al_enemigo(self, mi_disparo, el_enemigo):
//        """Es el método que se invoca cuando se produce una colisión 'tiro <-> enemigo'
//
//        :param mi_disparo: El disparo de la nave.
//        :param el_enemigo: El enemigo que se eliminará.
//        """
//        mi_disparo.eliminar()
//        el_enemigo.eliminar()
}