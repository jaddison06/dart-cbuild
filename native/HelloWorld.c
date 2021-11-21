// HelloWorld.c is the implementation of our library called HelloWorld

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// This file contains generated enum definitions
#include "c_codegen.h"

// A struct which can print a message a few times
typedef struct {
    char* message;
    int times;
} HelloWorldStruct;

// Say hello!
void HelloWorld() {
    printf("Hello, World!\n");
}

// Say hello, with a bit more control. Notice how Hello works just like a normal C enum.
void HelloEnums(Hello hello) {
    switch (hello) {
        case Hello_World: {
            printf("Hello, World!\n");
            break;
        }
        case Hello_Dart: {
            printf("Hello, Dart!\n");
            break;
        }
    }
}

// Initializer for the HelloWorldStruct. Will be used as the Dart constructor. Must return a void*
void* HWStructInit(const char* message, int times) {
    HelloWorldStruct* out = malloc(sizeof(HelloWorldStruct));

    out->message = malloc(strlen(message) + 1);

    // I don't trust the strings that Dart passes me, so i'll make a copy in case the original disappears
    strcpy(out->message, message);

    out->times = times;

    return out;
}

// From here onwards, everything is a "method" on HelloWorldStruct. So the first argument is always going to be a pointer to the struct.

// Free the HelloWorldStruct. Dart doesn't have destructors so we'll eventually have to call this manually.
void HWStructDestroy(HelloWorldStruct* self) {
    free(self->message);
    free(self);
}

// Remember what I was saying about boilerplate? This will be a Dart member variable, implemented as a getter.
int HWStructGetTimes(HelloWorldStruct* self) {
    return self->times;
}

// Print the message, some amount of times
void HWStructPrint(HelloWorldStruct* self) {
    for (int i=0; i<self->times; i++) {
        printf("%s\n", self->message);
    }
}

// Print the message, but ignore self->times and use n instead. Again, notice how n is just a normal C integer argument.
void HWStructPrintN(HelloWorldStruct* self, int n) {
    for (int i=0; i<n; i++) {
        printf("%s\n", self->message);
    }
}