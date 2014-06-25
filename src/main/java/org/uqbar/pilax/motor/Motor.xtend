package org.uqbar.pilax.motor

import org.uqbar.pilax.engine.GestorEscenas
import org.uqbar.pilax.engine.Mundo
import org.uqbar.pilax.geom.Area

/**
 * Abstracción sobre el motor de dibujado.
 * Permite separar todo pilax de la tecnología que se usa
 * por debajo para el dibujado.
 * Inicialmente pilas usa Qt.
 * Pero con esta interfaz podríamos tener otras implementaciones
 * como Java2d, o eclipse2d, etc.
 * 
 * @author jfernandes
 */
interface Motor {
	
	def void iniciarVentana(int ancho, int alto, String titulo, boolean pantalla_completa, GestorEscenas gestor, float rendimiento)
	def void ejecutarBuclePrincipal(Mundo mundo)
	def void visible()
	def void terminar()
	
	def Pair<Double, Double> getArea()
	def Pair<Double, Double> getCentroDeLaCamara()
	def void setCentroDeLaCamara(Pair<Double, Double> centro)
	def Pair<Double, Double> getCentroFisico()
	def double getAncho()
	def Area getBordes()
	
	def Pair<Integer, Integer> obtenerAreaDeTexto(String texto) 
	def Pair<Integer, Integer> obtenerAreaDeTexto(String texto, int magnitud, boolean vertical, String fuente) 
	
	// **********************
	// ** factory methods
	// **********************	
	
	def ImagenMotor cargarImagen(String path)
	def ActorMotor crearActor(ImagenMotor imagen, double x, double y)
	def Superficie crearSuperficie(int ancho, int alto)
	def TextoMotor crearTexto(String texto, int magnitud, String fuente)
}