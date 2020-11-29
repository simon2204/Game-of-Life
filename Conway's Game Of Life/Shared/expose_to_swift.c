//
//  expose_to_swift.c
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 29.11.20.
//

#include "game_of_life.h"
#include "expose_to_swift.h"
#include <stdio.h>
#include <stdbool.h>


bool is_bit_set_at_index(int index)
{
    return is_set(index, generation);
}

bool next_generation(void)
{
    return set_next_generation();
}

void set_bit_at_index(int index)
{
    set_bit(index, generation);
}

void delete_bit_at_index(int index)
{
    delete_bit(index, generation);
}
