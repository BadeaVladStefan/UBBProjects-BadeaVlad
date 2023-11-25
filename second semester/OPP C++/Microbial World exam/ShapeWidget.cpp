#include "ShapeWidget.h"

ShapeWidget::ShapeWidget(QWidget* parent) : QWidget(parent), shape(Shape::Circle) {}

void ShapeWidget::paintEvent(QPaintEvent* event)
{
    QPainter painter(this);
    painter.setRenderHint(QPainter::Antialiasing);

    QRectF shapeRect = QRectF(0, 0, width(), height());

    switch (shape)
    {
    case Shape::Circle:
        painter.setBrush(Qt::blue);
        painter.drawEllipse(shapeRect);
        break;
    case Shape::Triangle:
        painter.setBrush(Qt::red);
        QVector<QPointF> points;
        points << shapeRect.bottomLeft() << shapeRect.bottomRight() << shapeRect.center();
        painter.drawPolygon(points);
        break;
        // Add more cases for other shapes
    }
}