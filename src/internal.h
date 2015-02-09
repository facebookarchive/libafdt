/*
 *  Copyright (c) 2009, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#ifndef _INTERNAL_H
#define _INTERNAL_H

#include <stddef.h>

static inline void set_error(
    struct afdt_error_t* err,
    enum afdt_operation operation,
    const char* message) {
  if (err != NULL) {
    err->operation = operation;
    err->message = message;
  }
}

#endif // _INTERNAL_H
