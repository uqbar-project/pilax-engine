package org.uqbar.pilax.actores

import java.util.List
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.eventos.DataEventoMovimiento
import org.uqbar.pilax.motor.GrillaImagen
import org.uqbar.pilax.motor.Superficie

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

class Mapa extends Actor {
	int filas = 20
	int columnas = 20
	GrillaImagen grilla
	Superficie superficie
	Pair<Double,Double> centro_mapa
	List<List<Boolean>> matriz_de_bloques
	
	new(GrillaImagen grilla, double x, double y) {
		super('invisible.png', x, y)
		matriz_de_bloques = generar_matriz_de_bloques(filas, columnas)
		
		this.grilla = grilla
		if (grilla == null)
        	this.grilla = new GrillaImagen("grillas/plataformas_10_10.png", 10, 10)
        
        superficie = Pilas.instance.mundo.motor.crearSuperficie(columnas * grilla.cuadroAncho.intValue, filas * grilla.cuadroAlto.intValue)
        centro_mapa  = superficie.centro

        Pilas.instance.escenaActual.mueveCamara.conectar[d| actualizar_imagen(d)]
        this.fijo = true
	}
	
	def actualizar_imagen(DataEventoMovimiento movimiento) {
		val area = mundo.area
        val areaCamara = escena.camara.areaVisible
        val coordenadas = convertir_de_coordenada_absoluta_a_coordenada_mapa(areaCamara.izquierda, areaCamara.arriba)
        this.imagen = superficie.obtener_recuadro(coordenadas.x, coordenadas.y, area.ancho, area.alto)
    }
	
	def convertir_de_coordenada_absoluta_a_coordenada_mapa(double x, double y) {
		val centroFisico = mundo.motor.centroFisico
		val tx = x + centroFisico.x - self.x
        val ty = -y + centroFisico.y + self.y
        return tx -> ty
	}
	
	def generar_matriz_de_bloques(int filas, int columnas) {
		val cols = #[false] * columnas
        val matriz_de_bloques = newArrayList

        for (indice_fila : range(filas))
            matriz_de_bloques.add(copy(cols))

        matriz_de_bloques
	}
	
	def pintar_bloque(int fila, int columna, int indice) {
		pintar_bloque(fila, columna, indice, true)
	}
	
	def pintar_bloque(int fila, int columna, int indice, boolean es_bloque_solido) {
        matriz_de_bloques.get(fila).set(columna, es_bloque_solido)

        // Definimos el cuadro que deseamos dibujar en la Superficie.
        grilla.setCuadro(indice)

        // Dibujamos el cuadro de la grilla en la Superficie.
        val ancho = grilla.cuadroAncho
        val alto = grilla.cuadroAlto

        val x = columna * ancho
        val y = fila * alto

        grilla.dibujarse_sobre_una_pizarra(superficie, x.intValue, y.intValue)

        actualizar_imagen(null)
    }
    
    def pintar_limite_de_bloques() {
        for (fila : range(filas))
            for (columna : range(columnas))
                _pintar_borde_de_grilla(fila, columna)
	}

    def _pintar_borde_de_grilla(int fila, int columna) {
        val ancho = grilla.cuadroAncho
        val alto = grilla.cuadroAlto
        val x = columna * ancho
        val y = fila * alto

        superficie.rectangulo(x.intValue+1, y.intValue+1, ancho.intValue - 2, alto.intValue - 2)

        val texto_coordenada = fila + "," + columna
        superficie.texto(texto_coordenada, x.intValue+3, y.intValue-3 + alto.intValue, 8)
    }
	
	def obtener_distancia_al_suelo(int x, int y, int maximo) {
        // TODO: se puede hacer mas eficiente el algoritmo si en lugar
        //       de recorrer desde 0 a maximo solamente se recorre dando
        //       saltos por bloques (de 'self.grilla.cuadro_alto' pixels)
        try {
            val coord = convertir_de_coordenada_absoluta_a_coordenada_mapa(x, y)

            // El 'resto' es la coordenada 'y' interna a ese tile dentro
            // del mapa.
            val resto = coord.y % self.grilla.cuadroAlto

            if (resto != 0 && es_punto_solido_coordenada_mapa(x, y))
                return 0

            // Es la distancia en pixels a la siguiente fila que se
            // tiene que evaluar.
            val inicial = self.grilla.cuadroAlto - resto

            // Recorre el escenario hacia abajo, saltando por las filas
            // del mapa. Si encuentra un suelo se detiene y retorna la
            // cantidad de pixels que recorrió.
            for (distancia : range(inicial.intValue, maximo, grilla.cuadroAlto.intValue))
                if (es_punto_solido_coordenada_mapa(x, y+distancia))
                    return distancia
		}
		catch (RuntimeException e) {
			e.printStackTrace
            return maximo
        }
        return maximo
	}
	
    def es_bloque_solido(int fila, int columna) {
        if (fila < 0 || fila >= filas || columna < 0 || columna >= columnas)
            return true
        return matriz_de_bloques.get(fila).get(columna)
	}
	
	def es_punto_solido(int x, int y) {
        val coord = convertir_de_coordenada_absoluta_a_coordenada_mapa(x, y)
        return es_punto_solido_coordenada_mapa(coord.x.intValue, coord.y.intValue)
	}
	
	def es_punto_solido_coordenada_mapa(int x, int y) {
        val fila = obtener_numero_de_fila(y)
        val columna = obtener_numero_de_columna(x)
        return es_bloque_solido(fila, columna)
    }
    
    def obtener_numero_de_fila(int y) {
        return _convertir_en_int(y / grilla.cuadroAlto)
	}

    def obtener_numero_de_columna(int x) {
        return _convertir_en_int(x / grilla.cuadroAncho)
    }
    
    def _convertir_en_int(double valor) {
        return Math.floor(valor).intValue
    }
}