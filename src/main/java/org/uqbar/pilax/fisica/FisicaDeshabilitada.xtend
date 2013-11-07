package org.uqbar.pilax.fisica

import org.eclipse.xtext.xbase.lib.Pair

class FisicaDeshabilitada implements MotorFisica {

	new(Pair<Integer, Integer> area, Pair<Integer,Integer> gravedad) {
	}

	override actualizar() {}
    override reiniciar() {}

	override pausarMundo() {}
	override reanudarMundo() {}

	override eliminarFigura(Figura f) {}

}
