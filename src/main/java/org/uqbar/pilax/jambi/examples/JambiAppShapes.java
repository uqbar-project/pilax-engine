package org.uqbar.pilax.jambi.examples;

import com.trolltech.qt.core.QPoint;
import com.trolltech.qt.core.QPointF;
import com.trolltech.qt.gui.QApplication;
import com.trolltech.qt.gui.QBrush;
import com.trolltech.qt.gui.QColor;
import com.trolltech.qt.gui.QFont;
import com.trolltech.qt.gui.QPaintEvent;
import com.trolltech.qt.gui.QPainter;
import com.trolltech.qt.gui.QPainter.RenderHint;
import com.trolltech.qt.gui.QPainterPath;
import com.trolltech.qt.gui.QPen;
import com.trolltech.qt.gui.QPolygon;
import com.trolltech.qt.gui.QWidget;
import java.util.ArrayList;
import java.util.List;

/**
 * ZetCode QtJambi tutorial
 *
 * This program draws basic shapes
 * available in QtJambi
 *
 * @author jan bodnar
 * website zetcode.com
 * last modified March 2009
 */

public class JambiAppShapes extends QWidget {
    
    public JambiAppShapes() {
        setWindowTitle("Shapes");

        resize(350, 280);
        move(400, 300);
        show();
    }

    @Override
    protected void paintEvent(QPaintEvent event) {
        QPainter painter = new QPainter(this);
        drawShapes(painter);
    }

    private void drawShapes(QPainter painter) {
        painter.setRenderHints(new QPainter.RenderHints(QPainter.RenderHint.Antialiasing,
        			QPainter.RenderHint.HighQualityAntialiasing,
        			QPainter.RenderHint.SmoothPixmapTransform));
        painter.setPen(new QPen(new QBrush(QColor.darkGray), 1));
        painter.setBrush(QColor.darkGray);

        QPainterPath path1 = new QPainterPath();

        path1.moveTo(5, 5);
        path1.cubicTo(40, 5,  50, 50,  99, 99);
        path1.cubicTo(5, 99,  50, 50,  5, 5);
        painter.drawPath(path1);

        painter.drawPie(130, 20, 90, 60, 30*16, 120*16);
        painter.drawChord(240, 30, 90, 60, 0, 16*180);
        painter.drawRoundRect(20, 120, 80, 50);

        List<QPoint> points = new ArrayList<QPoint>();
        points.add(new QPoint(130, 140));
        points.add(new QPoint(180, 170));
        points.add(new QPoint(180, 140));
        points.add(new QPoint(220, 110));
        points.add(new QPoint(140, 100));

        QPolygon polygon = new QPolygon(points);

        painter.drawPolygon(polygon);
        painter.drawRect(250, 110, 60, 60);

        QPointF baseline = new QPointF(20, 250);
        QFont font = new QFont("Georgia", 55);
        QPainterPath path2 = new QPainterPath();
        path2.addText(baseline, font, "Q");
        painter.drawPath(path2);

        painter.drawEllipse(140, 200, 60, 60);
        painter.drawEllipse(240, 200, 90, 60);
    }
    
    
    public static void main(String[] args) {
        QApplication.initialize(args);
        new JambiAppShapes();
        QApplication.exec();
    }
}