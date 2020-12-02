//
//  game_of_life.c
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 29.11.20.
//

#include "game_of_life.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>

enum neighbour: int {
    topLeft, topRight,
    bottomLeft, bottomRight,
    top, bottom,
    left, right,
    all_neighbours
};

// MARK: Required functions

/// Gibt den aktuellen Zustand der Generation im Terminal aus.
void print_generation(void);

/// Initialisiert die Anfangsgeneration als Bit-Folge, repräsentiert durch einen String.
/// Eine ‘1‘ bedeutet, dass die Zelle ein Lebewesen enthält, und eine ‘0‘, dass die Zelle kein Lebewesen enthält.
void set_generation_from_string(char string[]);

/// Gibt den aktuellen Zustand der Generation in der Variable `values` zurück.
void get_generation_as_string(char string[]);

/// Berechnet ausgehend von der akutellen Generation die nächste Generation.
/// @return true, wenn die Nachfolgegeneration sich gegenüber der Ausgangsgeneration geändert hat.
bool set_next_generation(void);

/// Berechnet solange die Generationen  und gibt diese am Bildschirm aus, bis sich die Generationen
/// nicht mehr ändern oder die Anzahl der berechneten Generationen der durch max_generations übergebenen Anzahl entspricht.
/// @param max_generations - Anzahl der Berechnungen und Ausgaben  der Generationen.
void game_of_life(int max_generations);

// MARK: Custom functions

/// Setzt das Bit auf ‘1‘, an der Stelle `index` in der übergebenen `generation`.
/// @param index - Position des Bits.
/// @param generation - Generation, die verändert werden soll.
void set_bit(short index, unsigned char generation[]);

/// Setzt das Bit auf ‘0‘, an der Stelle `index` in der übergebenen `generation`.
/// @param index - Position des Bits.
/// @param generation - Generation, die verändert werden soll.
void delete_bit(short index, unsigned char generation[]);


/// Überprüft ob ein Bit gesetzt oder nicht gesetzt ist an Stelle `index`, in der übergebenen `generation`.
/// @param index - Position des Bits
/// @param generation - Generation, in der die Abfrage geschehen soll.
/// @return true, falls das Bit an Stelle `index` gesetzt ist.
bool is_set(short index, unsigned char generation[]);

/// Überprüft ob ein Bit gesetzt oder nicht gesetzt ist an einer bestimmten Stelle, repräsentiert durch `row` und `column`,
/// in der übergebenen `generation`.
/// @param row - Zeile, in der sich das Bit befindet.
/// @param column - Spalte, in der sich das Bit befindet.
/// @param generation - Generation, in der die Abfrage geschehen soll.
/// @return true, falls das Bit in der Zeile `row` und in der Spalte `column` gesetzt ist.
bool is_set_for_cell(short row, short column, unsigned char generation[]);


/// Überprüft, ob der Nachbar `n`, von `index` gesetzt ist.
/// @param n - Nachbar von `index`.
/// @param index - Index, der maximal acht Nachbarn hat.
/// @param generation - Generation, in der die Abfrage geschehen soll.
/// @return true, falls es den Nachbarn `n` für `index` gibt.
bool is_set_for_neighbour(enum neighbour n, short index, unsigned char generation[]);

/// Zählt die Nachbarn von `index`.
/// @param index - Index, dessen Nachbarn gezählt werden soll.
/// @param generation - Generation, in der die Abfrage geschehen soll.
/// @return Gibt die Anzahl der Nachbarn von `index` zurück.
short count_neighbours(short index, unsigned char generation[]);

/// Liefert die Repräsentation eines Lebewesens, falls es in einer bestimmten Zeile `row` und Spalte `column` existiert.
/// @return Repräsentation des Lebewesens.
char char_in_field(short row, short column);

#define ALL_ROWS 10
#define ALL_COLS 10
#define ALL_CELLS (ALL_ROWS * ALL_COLS)
#define ALL_CELLS_IN_BYTE (ALL_CELLS / 8)
#define SEGMENTS (ALL_CELLS_IN_BYTE + 1)

unsigned char generation[SEGMENTS];
unsigned char generation_copy[SEGMENTS];


// MARK: Initialisierung

int _main()
{
    char glider[] =
    "0000000100"
    "0000000101"
    "0010000110"
    "0010100000"
    "0011000000"
    "0000000000"
    "0000000000"
    "0000000000"
    "0000000000"
    "0000000000";
    
//    char sonne[] =
//    "0001100000"
//    "0010010000"
//    "0100001000"
//    "1000000100"
//    "1000000100"
//    "0100001000"
//    "0010010000"
//    "0001100000"
//    "0000000000"
//    "0000000000";
    
//    char beispiel_aus_aufgabenstellung[] = "111000001000010111000100000010";
    
    set_generation_from_string(glider);
//    print_generation();
//    game_of_life(30);
    
    return 1;
}

void game_of_life(int max_generations)
{
    int i;
    bool isMutating = true;
    for (i = 0; i < max_generations && isMutating; i++)
    {
        isMutating = set_next_generation();
        printf("%d\n", i);
        print_generation();
        usleep(1000000 / 3);
    }
}

bool set_next_generation()
{
    bool did_mutate = false;
    short n_count;
    int i;
    int j;
    
    for(j = 0; j < SEGMENTS; j++)
    {
        generation_copy[j] = generation[j];
    }
    
    for (i = 0; i < ALL_CELLS; i++)
    {
        n_count = count_neighbours(i, generation_copy);
        
        if (is_set(i, generation_copy))
        {
            // Feld ist mit einem Lebewesen belegt
            // Hat das Lebewesen weniger als zwei oder mehr als drei Nachbarn
            if (n_count < 2 || n_count > 3)
            {
                // Lebewesen stirbt
                delete_bit(i, generation);
                did_mutate = true;
            }
        }
        else
        {
            // Feld ist unbelegt, aber hat drei belegte Nachbarsfelder
            if (n_count == 3)
            {
                // Es entsteht ein neues Lebewesen
                set_bit(i, generation);
                did_mutate = true;
            }
        }
    }
    
    return did_mutate;
}

void set_generation_from_string(char string[ALL_CELLS])
{
    int i = 0;
    char charakter = string[i];
    while (charakter != '\0')
    {
        if (charakter == '0')
        {
            delete_bit(i, generation);
        }
        else
        {
            set_bit(i, generation);
        }
        
        i++;
        charakter = string[i];
    }
}

void get_generation_as_string(char string[ALL_CELLS])
{
    int i;
    for (i = 0; i < ALL_CELLS; i++)
    {
        string[i] = is_set(i, generation) ? '1' : '0';
    }
}

// MARK: Set and delete Bit

void set_bit(short index, unsigned char generation[SEGMENTS])
{
    // Befindet sich der Index außerhalb des Feldes, dann return.
    if (index < 0 || index >= ALL_CELLS)
    {
        return;
    }
    short segment = index / 8;
    short element = index % 8;
    generation[segment] |= (0x80u >> element);
}


void delete_bit(short index, unsigned char generation[SEGMENTS])
{
    // Befindet sich der Index außerhalb des Feldes, dann return.
    if (index < 0 || index >= ALL_CELLS)
    {
        return;
    }
    short segment = index / 8;
    short element = index % 8;
    generation[segment] &= ~(0x80u >> element);
}

// MARK: Is bit set?

bool is_set(short index, unsigned char generation[SEGMENTS])
{
    // Befindet sich der Index außerhalb des Feldes, dann betrachte es als nicht gesetzt.
    if (index < 0 || index >= ALL_CELLS)
    {
        return false;
    }
    short segment = index / 8;
    short element = index % 8;
    return ((0x80u >> element) & generation[segment]) > 0;
}

bool is_set_for_cell(short row, short column, unsigned char generation[SEGMENTS])
{
    // Befindet sich der Index außerhalb des Feldes, dann betrachte es als nicht gesetzt.
    if (row < 0 || column < 0 || row >= ALL_ROWS || column >= ALL_COLS)
    {
        return false;
    }
    return is_set((row * ALL_COLS) + column, generation);
}

bool is_set_for_neighbour(enum neighbour n, short index, unsigned char generation[])
{
    short row = index / ALL_COLS;
    short column = index % ALL_COLS;
    switch (n) {
        case topLeft:
            return is_set_for_cell(row - 1, column - 1, generation);
        case topRight:
            return is_set_for_cell(row - 1, column + 1, generation);
        case bottomLeft:
            return is_set_for_cell(row + 1, column - 1, generation);
        case bottomRight:
            return is_set_for_cell(row + 1, column + 1, generation);
        case top:
            return is_set_for_cell(row - 1, column + 0, generation);
        case bottom:
            return is_set_for_cell(row + 1, column + 0, generation);
        case left:
            return is_set_for_cell(row + 0, column - 1, generation);
        case right:
            return is_set_for_cell(row + 0, column + 1, generation);
        default:
            return false;
    }
}

// MARK: Count neighbours

short count_neighbours(short index, unsigned char generation[SEGMENTS])
{
    short n_count = 0;
    enum neighbour n;
    
    for (n = 0; n < all_neighbours; n++)
    {
        if (is_set_for_neighbour(n, index, generation))
        {
            n_count++;
        }
    }
    
    return n_count;
}

// MARK: Print Generation

void print_generation()
{
    int i;
    int j;
    for (i = 0; i < ALL_COLS; i++)
    {
        printf("+---");
    }
    
    if (ALL_COLS > 0)
    {
        printf("+\n");
    }
    
    for (i = 0; i < ALL_ROWS; i++)
    {
        for (j = 0; j < ALL_COLS; j++)
        {
            printf("| %c ", char_in_field(i, j));
        }
        printf("|\n");
        
        for (j = 0; j < ALL_COLS; j++)
        {
            printf("+---");
        }
        printf("+\n");
    }
}

char char_in_field(short row, short column)
{
    return is_set_for_cell(row, column, generation) ? 'o' : ' ';
}


// MARK: - Funktions for Swift

int all_rows()
{
    return ALL_ROWS;
}

int all_cols()
{
    return ALL_COLS;
}

int get_segments()
{
    return SEGMENTS;
}

