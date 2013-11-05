package org.uqbar.pilax.fisica

import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.motor.qt.Motor

class FisicaDeshabilitada {

	new(Pair<Integer, Integer> area, Pair<Integer,Integer> gravedad) {
	}

	def actualizar() {
	}

	def dibujar_figuras_sobre_lienzo(Motor motor, Object lienzo , int grosor) {}

    def crear_bordes_del_escenario(){}

    def reiniciar(){}

    def capturar_figura_con_el_mouse(Object figura) {}

    def cuando_mueve_el_mouse(int x, int y) {}

    def cuando_suelta_el_mouse() {}

    def pausar_mundo(){}

    def reanudar_mundo(){}

//    def dibujar_figuras_sobre_lienzo(Motor motor, Object lienzo, int grosor){}

    def crear_cuerpo(Object definicion_de_cuerpo){}

    def crear_suelo(int ancho, int alto, int restitucion){}

    def crear_techo(int ancho, int alto, int restitucion){}

    def crear_paredes(int ancho, int alto, int restitucion){}

    def eliminar_suelo(){}

    def eliminar_techo(){}

    def eliminar_paredes(){}

    def obtener_distancia_al_suelo(int x, int y, int dy){}

    def eliminar_figura(Object figura){}

    def obtener_cuerpos_en(int x, int y){}

    def definir_gravedad(int x, int y){}
	
}
