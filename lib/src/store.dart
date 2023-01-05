//  Copyright 2023 Google LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import 'model.dart';

class Layerring {
  Layerring(Dependencies dependencies) : files = _depsToFiles(dependencies);

  late final Map<FullName, SourceFile> files;
}

Map<FullName, SourceFile> _depsToFiles(Dependencies dependencies) {
  final result = <FullName, SourceFile>{};
  for (final consumerName in dependencies.keys) {
    for (final dependencyName in dependencies[consumerName]!) {
      result.putIfAbsent(consumerName, () => SourceFile(consumerName));
      result.putIfAbsent(dependencyName, () => SourceFile(dependencyName));

      final consumer = result[consumerName]!;
      final dependency = result[dependencyName]!;

      consumer.dependencies.add(dependency);
    }
  }
  return result;
}
