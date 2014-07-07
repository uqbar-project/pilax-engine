package org.uqbar.pilax.motor.qt

import org.uqbar.pilax.motor.java2d.FPSCounter

class FPS implements FPSCounter {
	@Property String cuadros_por_segundo = "??"
   	double frecuencia
    double siguiente
//    QTime timer
    int cuadros
    double ultimo_reporte_fps
    int cuadros_por_segundo_numerico
	
	new(double fps, boolean usarModoEconomico) {
		cuadros_por_segundo = "??"
        frecuencia = 1000.0 / fps
//        timer = new QTime
//        timer.start
//        siguiente = timer.elapsed + frecuencia
		siguiente = System.currentTimeMillis + frecuencia
        cuadros = 0
        ultimo_reporte_fps = 0
        cuadros_por_segundo_numerico = 0
	}
	
	override actualizar() {
//        var actual = timer.elapsed
		var actual = System.currentTimeMillis
        if (actual > siguiente) {
            var cantidad = 0

            while (actual > siguiente) {
                siguiente = siguiente + frecuencia
                cantidad = cantidad + 1
                _procesar_fps(actual)
			}
            if (cantidad > 10)
                cantidad = 10

            cuadros = cuadros + 1
            return cantidad
        }
        else
           // wait
           return 0
    }

    def _procesar_fps(double actual) {
        if (actual - ultimo_reporte_fps > 1000.0) {
            ultimo_reporte_fps = ultimo_reporte_fps + 1000.0
            cuadros_por_segundo = String.valueOf(cuadros)
            cuadros_por_segundo_numerico = cuadros
            cuadros = 0
        }
    }
	
}