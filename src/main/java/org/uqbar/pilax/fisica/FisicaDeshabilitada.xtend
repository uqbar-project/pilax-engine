package org.uqbar.pilax.fisica

class FisicaDeshabilitada implements MotorFisica {

	override actualizar() {}
    override reiniciar() {}

	override pausarMundo() {}
	override reanudarMundo() {}

	override eliminarFigura(Figura f) {}

}
