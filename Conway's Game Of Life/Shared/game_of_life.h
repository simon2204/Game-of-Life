//
//  game_of_life.h
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 29.11.20.
//

#ifndef game_of_life_h
#define game_of_life_h

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>

#endif /* game_of_life_h */

extern void game_of_life(int max_generations);

extern void set_generation_from_string(char string[]);

int all_rows(void);

int all_cols(void);

int get_segments(void);

bool is_bit_set_at_index(int index);

void set_bit_at_index(int index);

void delete_bit_at_index(int index);

bool next_generation(void);
