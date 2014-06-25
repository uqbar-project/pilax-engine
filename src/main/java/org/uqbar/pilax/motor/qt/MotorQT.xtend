package org.uqbar.pilax.motor.qt

import com.trolltech.qt.gui.QApplication
import com.trolltech.qt.gui.QFont
import com.trolltech.qt.gui.QFontMetrics
import org.uqbar.pilax.engine.GestorEscenas
import org.uqbar.pilax.engine.Mundo
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.geom.Area
import org.uqbar.pilax.motor.ActorMotor
import org.uqbar.pilax.motor.ImagenMotor
import org.uqbar.pilax.motor.Lienzo
import org.uqbar.pilax.motor.Motor
import org.uqbar.pilax.motor.Superficie
import org.uqbar.pilax.motor.TextoMotor

import static extension org.uqbar.pilax.utils.PilasExtensions.*

/**
 * Implementacion del Motor basada en QT
 * 
 * @author jfernandes
 */
class MotorQT implements Motor {
	QApplication application
	double anchoOriginal
	double altoOriginal
	String titulo
	@Property Ventana ventana
	@Property Pair<Double, Double> centroDeLaCamara = origen
	CanvasNormalWidget canvas
	boolean permitirDepuracion = true
	
	new() {
		// iniciar audio
		iniciarAplicacion
	}
	
	def iniciarAplicacion() {
		QApplication.initialize(newArrayOfSize(0))
		application = QApplication.instance()
	}	
	
	override iniciarVentana(int ancho, int alto, String titulo, boolean pantalla_completa, GestorEscenas gestor, float rendimiento) {
		anchoOriginal = ancho
		altoOriginal = alto
		
		this.titulo = titulo
		ventana = new Ventana(null)
		ventana.resize(ancho, alto)
        ventana.setWindowTitle(titulo)
		
		canvas = new CanvasNormalWidget(this, Pilas.instance.todosActores, ancho, alto, gestor, permitirDepuracion, rendimiento)
        ventana.canvas = canvas
        canvas.setFocus

      	ventana.show
        ventana.raise

        if (pantalla_completa) {
            canvas.pantallaCompleta
        }		
	}
	
	override crearActor(ImagenMotor imagen, double x, double y) {
		new ActorMotor(imagen, x, y)
	}
	
	/** Centro de la ventana para situar el punto (0, 0)*/
	override getCentroFisico() {
        area / 2
	}
	
	override getArea() {
		(anchoOriginal -> altoOriginal)
	}
	
	override ejecutarBuclePrincipal(Mundo mundo) {
		QApplication.exec
	}
	
	override visible() {
		ventana.show
	}
	
	override cargarImagen(String path) {
		new ImagenMotor(path)
	}
	
	override crearTexto(String texto, int magnitud, String fuente) {
       new TextoMotor(texto, magnitud, this, false, fuente)
    }
    
    override crearSuperficie(int ancho, int alto) {
    	new Superficie(ancho, alto)
    }
	
	override Pair<Integer, Integer> obtenerAreaDeTexto(String texto) {
		obtenerAreaDeTexto(texto, 10, false, null)
	}
	
	//TODO: cambio en pilas 0.82!
	override Pair<Integer, Integer> obtenerAreaDeTexto(String texto, int magnitud, boolean vertical, String fuente) {
		val nombre_de_fuente = if (fuente != null)
            						TextoMotor.cargar_fuente_desde_cache(fuente)
        						else
            						""
        val metrica = fontMetric(nombre_de_fuente, magnitud)

		var ancho = 0
        var alto = 0
        for (linea : lineas(texto, vertical)) {
            ancho = Math.max(ancho, metrica.width(linea))
            alto = alto + metrica.height
        }

        return ancho -> alto
	}
	
	def lineas(String texto, boolean vertical) {
//		if (vertical) 
//			texto.asStringArray //[t for t in texto]  PILAX  NO SE COMO HACER ESTO !
//		else
        	texto.split('\n')
	}
	
	def fontMetric(String fontName, int size) {
        new QFontMetrics(new QFont(fontName, size))
	}
	
	def crearLienzo() {
		new Lienzo
	}
	
	override getBordes() {
		val anchoBorde = area.ancho / 2
		val altoBorde = area.alto / 2
    	return new Area(-anchoBorde, anchoBorde, altoBorde, -altoBorde)
	}
	
	override getAncho() {
		ventana.width
	}
	
	override terminar() {
		ventana.close
	}
	
}