package org.uqbar.pilax.motor

import com.trolltech.qt.gui.QPainter
import org.uqbar.pilax.actores.interfaz.Pizarra

import static extension org.uqbar.pilax.motor.qt.QtExtensions.*
import org.uqbar.pilax.actores.interfaz.Canvas

class GrillaImagen extends ImagenMotor {
	int cantidadDeCuadros
	@Property double cuadroAncho
	@Property double cuadroAlto
	int columnas
	int filas
	double dx
	double dy
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
	
	override protected dibujarPixmap(PilasPainter painter, double x, double y) {
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
	
	def dibujarse_sobre_una_pizarra(Canvas pizarra, int x, int y) {
        pizarra.pintarParteDeImagen(this, dx, dy, cuadroAncho, cuadroAlto, x, y)
    }
}