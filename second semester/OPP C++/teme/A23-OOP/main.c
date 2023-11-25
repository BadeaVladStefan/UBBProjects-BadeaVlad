#include "Test.h"
#include "Repository.h"
#include "Service.h"
#include "Ui.h"


int main() {
    testAll();
    Repository* repo = createRepository(30);
    Service* service = createService(repo);
    Ui* ui = createUi(service);

    start(ui);
    destroyUi(ui);


    return 0;
}
