#include <jni.h>

static inline void test() {
    __builtin_printf("--> H\n");
}

extern "C" JNIEXPORT void JNICALL Java_mhahnFr_NDL_NDL_hello2(JNIEnv *, jclass) {
    __builtin_printf("Hello2\n");
    test();
}