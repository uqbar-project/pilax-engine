package org.uqbar.pilax.actores

/**
 * @author jfernandes
 */
enum PosicionCentro {
	IZQUIERDA, DERECHA,
	ARRIBA, ABAJO, CENTRO;
}

class PosicionCentroExtensions {
	def static double interpretar(PosicionCentro p, double value) {
		switch (p) {
			case PosicionCentro.IZQUIERDA: 0d
			case PosicionCentro.ARRIBA: 0d
			case PosicionCentro.CENTRO: (value / 2.0).intValue.doubleValue  // este truncado estaba en pilas ya. No me convence
			case PosicionCentro.DERECHA: value
			case PosicionCentro.ABAJO: value
		}
	}
	
	def static Pair<PosicionCentro,PosicionCentro> centrada(PosicionCentro p) {
		PosicionCentro.CENTRO -> PosicionCentro.CENTRO
	}
}