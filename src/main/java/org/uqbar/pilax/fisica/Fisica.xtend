package org.uqbar.pilax.fisica

import org.eclipse.xtext.xbase.lib.Pair

class Fisica {
	
	/**"""Genera el motor de física Box2D.

    :param area: El area de juego.
    :param gravedad: La gravedad del escenario.
    """ */
	def static crearMotorFisica(Pair<Integer, Integer> area, Pair<Integer,Integer> gravedad) {
		//TODO PILAX completar fisica con box2d
		
//	    if (__enabled__) {
//    	    if obtener_version().startswith('2.0') {
//            	print("Lo siento, el soporte para Box2D version 2.0 se ha eliminado.")
//            	print("Por favor actualice Box2D a la version 2.1 (ver http://www.pilas-engine.com.ar).")
//            	return FisicaDeshabilitada(area, gravedad)
//          	}
//        	else
//	            return Fisica(area, gravedad)
//        }
//	    else {
        	print("No se pudo iniciar Box2D, se deshabilita el soporte de Fisica.")
        	return new FisicaDeshabilitada(area, gravedad)
//      	}
	}
}