#include <QWidget>
#include "ui_DrawCircle.h"

class DrawCircle : public QWidget
{
    Q_OBJECT

public:
    explicit DrawCircle(QWidget* parent = nullptr);

protected:
    void paintEvent(QPaintEvent* event) override;

private:
    Ui::DrawCircleClass ui;
};


