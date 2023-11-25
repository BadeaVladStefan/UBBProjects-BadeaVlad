#pragma once

#include <QWidget>
#include "ui_DrawCircle.h"
#include <QApplication>
#include <QPainter>

class DrawCircle : public QWidget
{
	Q_OBJECT

public:
    void paintEvent(QPaintEvent*) override {
        QPainter painter(this);
        painter.setRenderHint(QPainter::Antialiasing, true);

        
        int circleX = 50;    
        int circleY = 50;    
        int radius = 30;    

        
        painter.setPen(Qt::black);      
        painter.setBrush(Qt::red);     
        painter.drawEllipse(circleX - radius, circleY - radius, radius * 2, radius * 2);
    }

private:
	Ui::DrawCircleClass ui;
};
