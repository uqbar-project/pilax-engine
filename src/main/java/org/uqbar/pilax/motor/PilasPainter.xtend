package org.uqbar.pilax.motor

import java.awt.Color

/**
 * Interfaz para abstraer todo pilax del engine de dibujado.
 * Por ejemplo hace polimórficos al QPainter de QT con Java2D Graphics2D
 * 
 * @author jfernandes
 */
interface PilasPainter {
	
	def void begin(PilasImage widget)
	def void end()
	
	def void save()
	def void restore()
	
	// 
	def void translate(double dx, double dy)
	def void rotate(double r)
	def void scale(double dx, double dy)
	def void setOpacity(double o)
	
	def void drawPixmap(int x, int y, PilasImage image)
	def void drawPixmap(int x, int y, PilasImage imagen, int dx, int dy, int cuadroAncho, int cuadroAlto)
	
	def void drawRect(PilasImage i, int x, int y, int width, int height, Color color, boolean fill, int tickness)
	def void drawCircle(PilasImage image, int x, int y, int radius, Color color, boolean fill, int tickness)
	
	def void drawLine(PilasImage imagen, int x, int y, int x2, int y2, Color color, int grosor)
	def void drawLine(Pair<Double,Double> p1, Pair<Double,Double> p2)
	
	def void drawText(PilasImage image, String text, int x, int y, int size, String font, Color color)
	def void drawMultiLineText(String text, double dx, double dy, int size, String font, Color color, int height)
	def void drawAbsoluteText(String text, double x, double y, int size, String font, Color color)
	
	def void drawTiledPixmap(Pair<Double, Double> origen, Pair<Double, Double> area, PilasImage image, Pair<Double, Double> dontKnow)
	def void drawTiledPixmap(PilasImage image, int x, int y, int ancho, int alto)
	
	def void setPen(Color color, int i)
	def void fillRect(Pair<Double, Double> p1, Pair<Double, Double> p2, Color color)
	def void drawEllipse(double x, double y, double w, double h)
	def void fillRect(Pair<Double,Double> p, double w, double h, Color color)
	def void drawRect(Pair<Double,Double> xy, double ancho, double alto)
	
}

interface PilasImage {
	def double getWidth()
	def void setWidth(double w)
	def double getHeight()
	def void setHeight(double h)
	def void fill(int r, int g, int b, int alpha)
	
	def ImagenMotor getBox(double d, double e, double f, double f2)
	
}