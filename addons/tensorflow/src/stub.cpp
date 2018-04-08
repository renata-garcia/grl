/** \file stub.cpp
 * \brief Tensorflow representation stub.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2018-04-07
 *
 * \copyright \verbatim
 * Copyright (c) 2018, Wouter Caarls
 * All rights reserved.
 *
 * This file is part of GRL, the Generic Reinforcement Learning library.
 *
 * GRL is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * \endverbatim
 */

#include <dlfcn.h>

#include <grl/grl.h>
#include <grl/configurable.h>

using namespace grl;

void init() __attribute__((constructor));

void init()
{
  NOTICE("Loading TensorFlow library");

  // The whole reason we're doing the stub thing is so we can load libtensorflow.so
  // with RTLD_DEEPBIND, so that it doesn't load the symbols of the protobuf
  // version our addon is linked with.
  if (!dlopen("libtensorflow.so", RTLD_NOW|RTLD_GLOBAL|RTLD_DEEPBIND))
    ERROR("Error loading tensorflow library 'libtensorflow.so': " << dlerror());
  
  std::string path = getLibraryPath() + "/lib2addon_tensorflow.so";

  NOTICE("Loading dependent plugin '" << path << "'");
  
  if (!dlopen(path.c_str(), RTLD_NOW|RTLD_LOCAL))
    ERROR("Error loading tensorflow '" << path << "': " << dlerror());
}
