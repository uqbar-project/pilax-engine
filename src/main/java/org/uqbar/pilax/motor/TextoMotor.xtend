package org.uqbar.pilax.motor

import java.awt.Color

/**
 * 
 * @author jfernandes
 */
class TextoMotor extends ImagenMotor {
    @Property boolean vertical
    @Property int magnitud
    @Property String fuente
    @Property Color color
    @Property String texto
    Pair<Integer,Integer> areaTexto

    new(String texto, int magnitud, Motor motor, boolean vertical, String fuente) {
    	this.texto = texto
        this.vertical = vertical
        this.fuente = fuente
        this.magnitud = magnitud
        this.areaTexto = motor.obtenerAreaDeTexto(texto, magnitud, vertical, fuente)
    }

    override dibujarPixmap(PilasPainter painter, double dx, double dy) {
    	painter.drawMultiLineText(texto, dx, dy, magnitud, fuente, color, alto.intValue)
	}
	
    override getAncho() { areaTexto.key }

    override getAlto() { areaTexto.value }
}