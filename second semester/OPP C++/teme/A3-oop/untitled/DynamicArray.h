//
// Created by Vlad on 3/19/2023.
//

#ifndef UNTITLED_DYNAMICARRAY_H
#define UNTITLED_DYNAMICARRAY_H
#pragma once
#include "Country.h"

typedef void* TElem;
typedef void (*DestroyElementFunction)(void *);
typedef TElem (*CopyElementFunction)(TElem);

typedef struct DynamicArray{
    TElem* elements;
    int length;
    int capacity;
    DestroyElementFunction destroyFunction;
    CopyElementFunction copyFunction;
}DynamicArray;


/*
 * input: 3 parameters - the capacity of the array, a function used to destroy the element, a function used to copy an element
 */
DynamicArray* createDynamicArray(int capacity, DestroyElementFunction destroyFunction, CopyElementFunction copyFunction);

/*
 * destroys a dynamic array
 */
void destroyDynamicArray(DynamicArray* array);

/*
 * adds an element to a dynamic array
 */
void addElement(DynamicArray* array,TElem element);

/*
 * deletes an element in the dynamic array
 */
void deleteElement(DynamicArray* array,int position);

/*
 * input: index of an item
 * return: the element at that index in the dynamic array
 */
void* getElementAtIndex(DynamicArray* array,int index);

int getArrayLength(DynamicArray* array);
TElem* getArrayElements(DynamicArray* array);
DynamicArray* copyDynamicArray(DynamicArray* arr);

#endif //UNTITLED_DYNAMICARRAY_H
