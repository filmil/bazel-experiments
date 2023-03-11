// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#ifndef _MACHINE_CREGS_H
#define _MACHINE_CREGS_H

#define CSR_READ(name, dst) asm volatile("csrr %0, " #name ";" : "=r"(dst))
#define CSR_WRITE(name, src) asm volatile("csrw " #name ", %0;" : : "r"(src))

/**
 * Enables/disables performance counters.  This affects mcycle and minstret as
 * well as the mhpmcounterN counters.
 *
 * Muntjac does not yet support disabling of counters, so this function
 * currently has no effect.
 *
 * @param enable if non-zero enables, otherwise disables
 */
void pcount_enable(int enable);

/**
 * Resets all performance counters.  This affects mcycle and minstret as well
 * as the mhpmcounterN counters.
 */
void pcount_reset();

#endif // _MACHINE_CREGS_H
