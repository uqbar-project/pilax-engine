package org.uqbar.pilax.motor.qt

import com.trolltech.qt.gui.QApplication
import com.trolltech.qt.gui.QFont
import com.trolltech.qt.gui.QFontDatabase
import com.trolltech.qt.gui.QFontMetrics
import com.trolltech.qt.gui.QPainter
import com.trolltech.qt.gui.QPixmap
import java.io.ByteArrayOutputStream
import java.io.File
import java.util.Map
import javax.imageio.ImageIO
import org.uqbar.pilax.engine.GestorEscenas
import org.uqbar.pilax.engine.Mundo
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.motor.java2d.AbstractMotor
import org.uqbar.pilax.utils.Utils

import static extension org.uqbar.pilax.utils.PilasExtensions.*

/**
 * Implementacion del Motor basada en QT
 * 
 * @author jfernandes
 */
class MotorQT extends AbstractMotor {
	QApplication application
	String titulo
	@Property Ventana ventana
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
		ventana = new Ventana(null) => [
			resize(ancho, alto)
    	    setWindowTitle(titulo)
		]
		
		canvas = new CanvasNormalWidget(this, Pilas.instance.todosActores, ancho, alto, gestor, permitirDepuracion, rendimiento)
        ventana.canvas = canvas
        canvas.setFocus

      	ventana.show
        ventana.raise

        if (pantalla_completa) {
            canvas.pantallaCompleta
        }		
	}
	
	override loadImage(String fullPath) {
		if (fullPath.toLowerCase.endsWith("jpeg") || fullPath.toLowerCase.endsWith("jpg")) {
           new QTImage(cargarJpeg(fullPath))
        }
        else {
           new QTImage(new QPixmap(fullPath))
        }
	}
	
	def QPixmap cargarJpeg(String ruta) {
		val byteArrayOut = new ByteArrayOutputStream        
        ImageIO.write(ImageIO.read(new File(ruta)), "png", byteArrayOut);
        val pixmapImage = new QPixmap()
        pixmapImage.loadFromData(byteArrayOut.toByteArray)
        pixmapImage
	}
	
	override createImage(int width, int height) { 	new QTImage(new QPixmap(width, height)) }
	
	override createPainter() {
		new QTPilasPainter(new QPainter /*  => [
			setRenderHint(QPainter.RenderHint.HighQualityAntialiasing, true)
        	setRenderHint(QPainter.RenderHint.SmoothPixmapTransform, true)
        	setRenderHint(QPainter.RenderHint.Antialiasing, true)
        ]*/
        )
	}
	
	override ejecutarBuclePrincipal(Mundo mundo) {
		QApplication.exec
	}
	
	override visible() {
		ventana.show
	}
	
	//TODO: cambio en pilas 0.82!
	override Pair<Integer, Integer> obtenerAreaDeTexto(String texto, int magnitud, boolean vertical, String fuente) {
		val nombre_de_fuente = if (fuente != null)
            						cargar_fuente_desde_cache(fuente)
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
	
	override getAncho() {
		ventana.width
	}
	
	override terminar() {
		ventana.close
	}
	
	// TODO: habilitar cache !
    static Map<String, Integer> CACHE_FUENTES = newHashMap()
	/**
     * Carga o convierte una fuente para ser utilizada dentro del motor.
     *
     * Permite a los usuarios referirse a las fuentes como ruta a archivos, sin
     *  tener que preocuparse por el font-family.
	 *
     * :param fuenteComoRuta: Ruta al archivo TTF que se quiere utilizar.
	 *	
     *  Ejemplo:
	 *
     *      >>> Texto.cargar_fuente_desde_cache('myttffile.ttf')
     *      'Visitor TTF1'
     */    
    public def static String cargar_fuente_desde_cache(String fuenteComoRuta) {
        var int idFuente
        if (!CACHE_FUENTES.containsKey(fuenteComoRuta)) {
            idFuente = QFontDatabase.addApplicationFont(Utils.obtenerRutaAlRecurso(fuenteComoRuta))
            CACHE_FUENTES.put(fuenteComoRuta, idFuente)
        }
        else
            idFuente = CACHE_FUENTES.get(fuenteComoRuta)

        return QFontDatabase.applicationFontFamilies(idFuente).first
    }
	
}