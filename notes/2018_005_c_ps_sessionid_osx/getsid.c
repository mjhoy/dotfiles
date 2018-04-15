#include <mikey/common.h>

int main() {
    pid_t sid = getsid(0);
    printf("  SESS\n     %d\n", sid);
}
