package org.uqbar.pilax.motor

import org.uqbar.pilax.motor.ImagenMotor
import com.trolltech.qt.gui.QPainter

class GrillaImagen extends ImagenMotor {
	int cantidadDeCuadros
	int cuadroAncho
	int cuadroAlto
	int columnas
	int filas
	int dx
	int dy
	int cuadro
	
	new(String ruta) {
		this(ruta, 1)
	}
	
	new(String ruta, int columnas) {
		this(ruta, columnas, 1)
	}
	
	new(String ruta, int columnas, int filas) {
        super(ruta)
        cantidadDeCuadros = columnas * filas
        this.columnas = columnas
        this.filas = filas
        cuadroAncho = super.ancho / columnas
        cuadroAlto = super.alto / filas
        setCuadro(0)
	}
	
	override getAncho() {
        return cuadroAncho
    }

    override getAlto() {
        cuadroAlto
    }
	
	def void setCuadro(int cuadro) {
		this.cuadro = cuadro
        val frameCol = cuadro % columnas
        val frameRow = cuadro / columnas

        dx = frameCol * cuadroAncho
        dy = frameRow * cuadroAlto
	}
	
	override protected dibujarPixmap(QPainter painter, int x, int y) {
		painter.drawPixmap(x, y, imagen, dx, dy, cuadroAncho, cuadroAlto)
	}
	
	override boolean avanzar() {
        var haAvanzado = true
        var cuadroActual = cuadro + 1

        if (cuadroActual >= cantidadDeCuadros) {
            cuadroActual = 0
            haAvanzado = false
        }
        setCuadro(cuadroActual)
        return haAvanzado
	}
}