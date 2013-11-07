package org.uqbar.pilax.motor

import org.uqbar.pilax.motor.ImagenMotor
import com.trolltech.qt.gui.QPainter

class GrillaImagen extends ImagenMotor {
	int cantidad_de_cuadros
	int cuadro_ancho
	int cuadro_alto
	int columnas
	int filas
	int dx
	int dy
	int cuadro
	
	new(String ruta) {
		this(ruta, 1, 1)
	}
	
	new(String ruta, int columnas, int filas) {
        super(ruta)
        cantidad_de_cuadros = columnas * filas
        this.columnas = columnas
        this.filas = filas
        cuadro_ancho = super.ancho / columnas
        cuadro_alto = super.alto / filas
        definir_cuadro(0)
	}
	
	override getAncho() {
        return cuadro_ancho
    }

    override getAlto() {
        cuadro_alto
    }
	
	def definir_cuadro(int cuadro) {
		this.cuadro = cuadro
        val frame_col = cuadro % columnas
        val frame_row = cuadro / columnas

        dx = frame_col * cuadro_ancho
        dy = frame_row * cuadro_alto
	}
	
	override protected dibujarPixmap(QPainter painter, int x, int y) {
		painter.drawPixmap(x, y, imagen, dx, dy, cuadro_ancho, cuadro_alto)
	}
	
	override boolean avanzar() {
        var ha_avanzado = true
        var cuadro_actual = cuadro + 1

        if (cuadro_actual >= cantidad_de_cuadros) {
            cuadro_actual = 0
            ha_avanzado = false
        }
        definir_cuadro(cuadro_actual)
        return ha_avanzado
	}
}