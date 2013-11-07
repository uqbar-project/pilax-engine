package org.uqbar.pilax.habilidades

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Habilidad
import org.uqbar.pilax.fisica.figuras.Circulo

import static extension org.uqbar.pilax.utils.PythonUtils.*

class RebotarComoPelota extends Habilidad {
	Circulo circulo
	
	new(Actor receptor) {       super(receptor)
        val error = randint(-10, 10) / 10.0

        circulo = new Circulo((receptor.x + error).intValue, (receptor.y + error).intValue, receptor.radioDeColision)
        receptor.aprender(Imitar) => [ objetoAImitar = circulo ]
        // PILAX !
//        receptor.impulsar = self.impulsar
//        receptor.empujar = self.empujar
	}
	
    override eliminar() {
        circulo.eliminar
	}
	
    def impulsar(int dx, int dy) {
        circulo.impulsar(dx, dy)
	}
	
    def empujar(int dx, int dy) {
        circulo.empujar(dx, dy)
	}
	
}