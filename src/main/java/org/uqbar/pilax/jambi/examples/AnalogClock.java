package org.uqbar.pilax.jambi.examples;

import com.trolltech.qt.core.*;
import com.trolltech.qt.gui.*;

// ! [0]
public class AnalogClock extends QWidget {
	static QPolygon hourHand = new QPolygon();
	static QPolygon minuteHand = new QPolygon();
	static {
		hourHand.append(new QPoint(7, 8));
		hourHand.append(new QPoint(-7, 8));
		hourHand.append(new QPoint(0, -40));
		minuteHand.append(new QPoint(7, 8));
		minuteHand.append(new QPoint(-7, 8));
		minuteHand.append(new QPoint(0, -70));
	}
	QTimer m_timer = new QTimer(this);

	// ! [0]
	// ! [1]
	public AnalogClock() {
		this(null);
	}

	// ! [1]
	public AnalogClock(QWidget parent) {
		super(parent);
		m_timer.timeout.connect(this, "update()");
		setWindowTitle("Analog clock");
		setWindowIcon(new QIcon("classpath:com/trolltech/images/qt-logo.png"));
		resize(200, 200);
	}

	@Override
	// ! [2]
	protected void paintEvent(QPaintEvent e) {
		QColor hourColor = new QColor(127, 0, 127);
		QColor minuteColor = new QColor(0, 127, 127, 191);
		int side = width() < height() ? width() : height();
		QTime time = QTime.currentTime();
		// ! [2]
		// ! [3]
		QPainter painter = new QPainter(this);
		painter.setRenderHint(QPainter.RenderHint.Antialiasing);
		painter.translate(width() / 2, height() / 2);
		painter.scale(side / 200.0f, side / 200.0f);
		// ! [3]
		// ! [4]
		painter.setPen(QPen.NoPen);
		painter.setBrush(hourColor);
		// ! [4]
		// ! [5]
		painter.save();
		painter.rotate(30.0f * ((time.hour() + time.minute() / 60.0f)));
		painter.drawConvexPolygon(hourHand);
		painter.restore();
		// ! [5]
		// ! [6]
		painter.setPen(hourColor);
		for (int i = 0; i < 12; ++i) {
			painter.drawLine(88, 0, 96, 0);
			painter.rotate(30.0f);
		}
		// ! [6]
		// ! [7]
		painter.setPen(QPen.NoPen);
		painter.setBrush(minuteColor);
		painter.save();
		painter.rotate(6.0f * (time.minute() + time.second() / 60.0f));
		painter.drawConvexPolygon(minuteHand);
		painter.restore();
		// ! [7]
		// ! [8]
		painter.setPen(minuteColor);
		for (int j = 0; j < 60; ++j) {
			if ((j % 5) != 0)
				painter.drawLine(92, 0, 96, 0);
			painter.rotate(6.0f);
		}
		// ! [8]
	}

	@Override
	public QSize sizeHint() {
		return new QSize(200, 200);
	}

	@Override
	// ! [9]
	public void showEvent(QShowEvent e) {
		m_timer.start(1000);
	}

	@Override
	public void hideEvent(QHideEvent e) {
		m_timer.stop();
		// ! [9] //! [10]
	}

	// ! [10]
	// ! [11]
	static public void main(String args[]) {
		QApplication.initialize(args);
		AnalogClock w = new AnalogClock();
		w.show();
		QApplication.exec();
	}
}
// ! [11]