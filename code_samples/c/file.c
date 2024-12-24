#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>

#define PI 3.14159
#define SQUARE(x) ((x) * (x))

typedef struct {
    double x, y;
    double radius;
} Circle;

double calculate_area(const Circle *c) {
    return PI * SQUARE(c->radius);
}

void print_array(const char *msg, int *arr, size_t size) {
    printf("%s: ", msg);
    for (size_t i = 0; i < size; i++) printf("%d ", arr[i]);
    printf("\n");
}

int main(void) {
    printf("=== Advanced C Program ===\n\n");

    Circle c = {2.0, 3.0, 5.0};
    printf("Circle at (%.2f, %.2f) with radius %.2f\n", c.x, c.y, c.radius);
    printf("Area of the circle: %.2f\n\n", calculate_area(&c));

    int *array = (int *)malloc(6 * sizeof(int));
    if (!array) { perror("Memory allocation failed"); return EXIT_FAILURE; }
    for (int i = 0; i < 6; i++) array[i] = i + 1;
    print_array("Original array", array, 6);

    for (int i = 0; i < 6; i++) array[i] = SQUARE(array[i]);
    print_array("Squared values", array, 6);

    free(array);
    return 0;
}
