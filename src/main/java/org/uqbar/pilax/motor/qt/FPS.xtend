package org.uqbar.pilax.motor.qt

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

import com.trolltech.qt.core.QTime

class FPS {
	String cuadros_por_segundo = "??"
   	double frecuencia
    double siguiente
    QTime timer
    int cuadros
    double ultimo_reporte_fps
    int cuadros_por_segundo_numerico
	
	new(double fps, boolean usarModoEconomico) {
		self.cuadros_por_segundo = "??"
        self.frecuencia = 1000.0 / fps
        self.timer = new QTime()
        self.timer.start()
        self.siguiente = self.timer.elapsed() + self.frecuencia
        self.cuadros = 0
        self.ultimo_reporte_fps = 0
        self.cuadros_por_segundo_numerico = 0
	}
	
	def actualizar() {
        var actual = self.timer.elapsed()
        if (actual > self.siguiente) {
            var cantidad = 0

            while (actual > self.siguiente) {
                self.siguiente = self.siguiente + self.frecuencia
                cantidad = cantidad + 1
                self._procesar_fps(actual)
			}
            if (cantidad > 10) {
                cantidad = 10
            }

            self.cuadros = self.cuadros + 1
            return cantidad
        }
        else {
           // wait
           return 0
        }
    }

    def _procesar_fps(double actual) {
        if (actual - self.ultimo_reporte_fps > 1000.0) {
            self.ultimo_reporte_fps = ultimo_reporte_fps + 1000.0
            self.cuadros_por_segundo = String.valueOf(self.cuadros)
            self.cuadros_por_segundo_numerico = self.cuadros
            self.cuadros = 0
        }
    }
	
}