cmake_minimum_required(VERSION 3.24)
project(untitled C)

set(CMAKE_C_STANDARD 11)

add_executable(untitled main.c Country.c Country.h Test.c Test.h DynamicArray.c DynamicArray.h Repository.c Repository.h Service.c Service.h Ui.c Ui.h)
