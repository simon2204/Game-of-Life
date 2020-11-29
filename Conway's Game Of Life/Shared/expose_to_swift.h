//
//  expose_to_swift.h
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 29.11.20.
//

#ifndef expose_to_swift_h
#define expose_to_swift_h

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>

#endif /* expose_to_swift_h */

bool is_bit_set_at_index(int index);

void set_bit_at_index(int index);

void delete_bit_at_index(int index);

bool next_generation(void);

extern unsigned char generation[];


