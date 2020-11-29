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

int _main(void);

extern void game_of_life(int max_generations);

extern void set_generation_from_string(char string[]);

extern bool is_set(short index, unsigned char generation[]);

extern bool set_next_generation(void);

extern void set_bit(short index, unsigned char generation[]);

extern void delete_bit(short index, unsigned char generation[]);

int all_rows(void);

int all_cols(void);

int get_segments(void);
